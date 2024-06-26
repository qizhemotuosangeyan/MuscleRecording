//
//  HunYuanNoteViewModel.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//

import Foundation
import Combine
import CryptoKit

class HunYuanNoteViewModel: ObservableObject {
    @Published var aiText = ""
    private var cancellable: AnyCancellable?
    let secretId = "AKIDPoFWXj4YzRqSGFObhkibaeq3KVXjyCVo"
    let secretKey = "Qm6NqHfwDVhl1R7i9oVB123vjht7BEAy"
    let service = "hunyuan"
    let host = "hunyuan.tencentcloudapi.com"
    let action = "ChatCompletions"
    let version = "2023-09-01"
    let algorithm = "TC3-HMAC-SHA256"
    let date = Date().toYYMMDDServerString()
    let ct = "application/json; charset=utf-8"
    let httpRequestMethod = "POST"
    let body: [String: Any] = [
        "TopP": 0,
        "Stream": false,
        "Temperature": 0,
        "Model": "hunyuan-pro",
        "Messages": [
            [
                "Role": "user",
                "Content": "你好呀！"
            ]
        ]
    ]
    
    struct Choice: Codable {
        let finishReason: String
        let message: Message
        
        enum CodingKeys: String, CodingKey {
            case finishReason = "FinishReason"
            case message = "Message"
        }
    }

    struct Message: Codable {
        let role: String
        let content: String
        
        enum CodingKeys: String, CodingKey {
            case role = "Role"
            case content = "Content"
        }
    }

    struct Usage: Codable {
        let promptTokens: Int
        let completionTokens: Int
        let totalTokens: Int
        
        enum CodingKeys: String, CodingKey {
            case promptTokens = "PromptTokens"
            case completionTokens = "CompletionTokens"
            case totalTokens = "TotalTokens"
        }
    }

    struct Response: Codable {
        let note: String
        let choices: [Choice]
        let created: Int
        let id: String
        let usage: Usage
        
        enum CodingKeys: String, CodingKey {
            case note = "Note"
            case choices = "Choices"
            case created = "Created"
            case id = "Id"
            case usage = "Usage"
        }
    }
    
    
    func fetchPosts() {
        guard let url = URL(string: "https://hunyuan.tencentcloudapi.com") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = httpRequestMethod
        request.setValue(ct, forHTTPHeaderField: "Content-Type")
        request.setValue(action, forHTTPHeaderField: "X-TC-Action")
        request.setValue(date, forHTTPHeaderField: "X-TC-Timestamp")
        request.setValue(version, forHTTPHeaderField: "X-TC-Version")
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            let authHeader = calcAuthorizationValue(body: jsonData)
            request.setValue(authHeader, forHTTPHeaderField: "Authorization")
            request.httpBody = jsonData
        } catch {
            print("Failed to encode JSON body: \(error.localizedDescription)")
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: request) //使用dataTaskPublisher将指令式变成转换为响应式编程，此Publisher会发布两个值：response和data，其中response是与本次请求相关的数据，例如状态码、协议、时间等。data是具体内容的二进制数据
            .map { $0.data } // 只需要发布者发布的data,而暂时不需要其他东西————此时map方法调用的是Publisher的map方法，$0指的是网络请求发布的那个二元组
            .decode(type: Response.self, decoder: JSONDecoder()) //将发布者发布的值用预备好的Post数组解析
            .map { response in
                response.choices.first?.message.content ?? "No content"
            }
            .receive(on: DispatchQueue.main) // 在主线程上发布，因为会驱动UI变化
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] content in
                self?.aiText = content
            })
    }
    private func calcAuthorizationValue(body: Data) -> String {
        // 需要设置环境变量 TENCENTCLOUD_SECRET_KEY，值为示例的 Gu5t9xGARNpq86cd98joQYCN3*******
        //let secretKey = ProcessInfo.processInfo.environment["TENCENTCLOUD_SECRET_KEY"]
        
        let timestamp = Date().timeIntervalSince1970

        // ************* 步骤 1：拼接规范请求串 *************
        
        let canonicalUri = "/"
        let canonicalQuerystring = ""
        let payload = body
        let hashedRequestPayload = sha256(data: body)
        let canonicalHeaders = "content-type:\(ct)\nhost:\(host)\nx-tc-action:\(action.lowercased())\n"
        let signedHeaders = "content-type;host"
        let canonicalRequest = """
        \(httpRequestMethod)
        \(canonicalUri)
        \(canonicalQuerystring)
        \(canonicalHeaders)
        \(signedHeaders)
        \(hashedRequestPayload)
        """

        // ************* 步骤 2：拼接待签名字符串 *************
        let credentialScope = "\(date)/\(service)/tc3_request"
        let hashedCanonicalRequest = sha256(msg: canonicalRequest)
        let stringToSign = """
        \(algorithm)
        \(timestamp)
        \(credentialScope)
        \(hashedCanonicalRequest)
        """

        // ************* 步骤 3：计算签名 *************
        let keyData = Data("TC3\(secretKey)".utf8)
        let dateData = Data(date.utf8)
        var symmetricKey = SymmetricKey(data: keyData)
        let secretDate = HMAC<SHA256>.authenticationCode(for: dateData, using: symmetricKey)
        let secretDateString = Data(secretDate).map{String(format: "%02hhx", $0)}.joined()

        let serviceData = Data(service.utf8)
        symmetricKey = SymmetricKey(data: Data(secretDate))
        let secretService = HMAC<SHA256>.authenticationCode(for: serviceData, using: symmetricKey)
        let secretServiceString = Data(secretService).map{String(format: "%02hhx", $0)}.joined()

        let signingData = Data("tc3_request".utf8)
        symmetricKey = SymmetricKey(data: secretService)
        let secretSigning = HMAC<SHA256>.authenticationCode(for: signingData, using: symmetricKey)
        let secretSigningString = Data(secretSigning).map{String(format: "%02hhx", $0)}.joined()

        let stringToSignData = Data(stringToSign.utf8)
        symmetricKey = SymmetricKey(data: secretSigning)
        let signature = HMAC<SHA256>.authenticationCode(for: stringToSignData, using: symmetricKey).map{String(format: "%02hhx", $0)}.joined()

        // ************* 步骤 4：拼接 Authorization *************
        let authorization = """
        \(algorithm) Credential=\(secretId)/\(credentialScope), SignedHeaders=\(signedHeaders), Signature=\(signature)
        """
        print("以下是authorization")
        print(authorization)
        return authorization
    }
    private func sha256(data: Data) -> String {
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    func sha256(msg: String) -> String {
        let data = msg.data(using: .utf8)!
        let digest = SHA256.hash(data: data)
        return digest.compactMap{String(format: "%02x", $0)}.joined()
    }
    
}


