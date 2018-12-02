import PlaygroundSupport
import UIKit

struct Resource<A> {
    let url: URL
    let parse: (Data) -> A?
}

struct MessageDefinition : Codable {
    let id: Int
    let content: String
}

let messagesUrl = URL(string: "https://raw.githubusercontent.com/RHoKAustralia/the-painspace/master/ThePainspace/Model/sample-messages.json")!

let messagesResource = Resource<[MessageDefinition]>(url: messagesUrl) { data in
    let decoder = JSONDecoder();
    let result = try! decoder.decode([MessageDefinition].self, from:data)
    return result;
}

final class Webservice {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { (data, _, _) in
            let result = data.flatMap(resource.parse)
            completion(result)
        }.resume()
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true

Webservice().load(resource: messagesResource) { result in
    print(result!)
}
