//
//  AINoteViewModel.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//
import Foundation
import Combine

// 定义API响应结构
struct ChatCompletionChunk: Codable {
    let id: String
    let created: Int
    let choices: [Choice]
    let model: String
    let object: String
    let usage: Usage
    let finalOut: String?

    enum CodingKeys: String, CodingKey {
        case id
        case created
        case choices
        case model
        case object
        case usage
        case finalOut = "final_out"
    }
}

struct Choice: Codable {
    let index: Int
    let finishReason: String
    let message: Message

    enum CodingKeys: String, CodingKey {
        case index
        case finishReason = "finish_reason"
        case message
    }
}

struct Message: Codable {
    let role: String
    let content: String
}

struct Usage: Codable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}

class AINoteViewModel: ObservableObject {
    @Published var aiText = ""
    private var cancellable: AnyCancellable?
    
    func fetchPosts(bodyDescription: String) {
        guard let url = URL(string: "https://api.atomecho.cn/v1/chat/completions") else {
            print("Invalid URL")
            return
        }
        
        // 创建请求体
        let requestBody: [String: Any] = [
            "model": "Atom-7B-Chat",
            "messages": [
                ["role": "user", "content": bodyDescription]
            ],
            "temperature": 0.3,
            "stream": false
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
            print("Failed to serialize request body")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer sk-f0cc4bf481ac3d4e738691cad90c6a7f", forHTTPHeaderField: "Authorization")
        request.httpBody = httpBody

        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                print("Response data: \(String(data: output.data, encoding: .utf8) ?? "No data")")
                return output.data
            }
            .decode(type: ChatCompletionChunk.self, decoder: JSONDecoder())
            .map { response in
                response.choices.compactMap { $0.message.content }.joined()
            }
            .catch { error -> Just<String> in
                print("Error: \(error.localizedDescription)")
                return Just("请求失败")
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.aiText, on: self)
    }
}
