//
//  AINoteViewModel.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//
import Foundation
import Combine

// 可作为网络请求典型案例进行学习

// 定义API响应结构————————————————————————————————————————————————————————
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
// ———————————————————————————————————————————————————————————————————————————————
class AINoteViewModel: ObservableObject {
    @Published var aiText = ""
    private var cancellable: AnyCancellable?
    
    func fetchPosts(bodyDescription: String) {
        // 字符串转URL
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
        
        // 请求题字典转Json Data
        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
            print("Failed to serialize request body")
            return
        }
        
        //填充好RestAPI：url，method，header，body
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer sk-f0cc4bf481ac3d4e738691cad90c6a7f", forHTTPHeaderField: "Authorization")
        request.httpBody = httpBody

        //使用dataTaskPunlisher方法就行网络请求，并将返回的cancellable持有
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                print("Response data: \(String(data: output.data, encoding: .utf8) ?? "No data")")
                return output.data
            } // output包含一个response和一个data，判断response正常则只取其中的data部分进行发布
            .decode(type: ChatCompletionChunk.self, decoder: JSONDecoder()) //将发布的data用定义好的Modeldecode
            .map { response in
                response.choices.compactMap { $0.message.content }.joined()
            } // 此时的response就是已经模型化后的对象，此处业务只需要message的content部分，所以
            .catch { error -> Just<String> in
                print("Error: \(error.localizedDescription)")
                return Just("请求失败")
            } // 发布的值如果出现错误则需要进行错误处理
            .receive(on: DispatchQueue.main) // 选择主线程发布，因为会影响UI
            .assign(to: \.aiText, on: self) //使用assign绑定发布给aiText文本
        // 千千总结：整体分几个步骤：1. 发布请求。2. 拿到相应结果。 3. data转模型。4. 结果处理到符合业务需求。5.错误处理。6. 选择发布线程，绑定UI
    }
}
