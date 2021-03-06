
import Foundation

struct Item: Codable {
	let id: Int
	let promoted: Int
	let up: Int
	let down: Int
	let created: Int
	let image: String
	let thumb: String
    let fullsize: String
	let width: Int
	let height: Int
	let audio: Bool
	let source: String
	let flags: Int
	let user: String
	let mark: Int
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(created))
    }

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case promoted = "promoted"
		case up = "up"
		case down = "down"
		case created = "created"
		case image = "image"
		case thumb = "thumb"
		case fullsize = "fullsize"
		case width = "width"
		case height = "height"
		case audio = "audio"
		case source = "source"
		case flags = "flags"
		case user = "user"
		case mark = "mark"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(Int.self, forKey: .id)
		promoted = try values.decode(Int.self, forKey: .promoted)
		up = try values.decode(Int.self, forKey: .up)
		down = try values.decode(Int.self, forKey: .down)
		created = try values.decode(Int.self, forKey: .created)
		image = try values.decode(String.self, forKey: .image)
		thumb = try values.decode(String.self, forKey: .thumb)
		fullsize = try values.decode(String.self, forKey: .fullsize)
		width = try values.decode(Int.self, forKey: .width)
		height = try values.decode(Int.self, forKey: .height)
		audio = try values.decode(Bool.self, forKey: .audio)
		source = try values.decode(String.self, forKey: .source)
		flags = try values.decode(Int.self, forKey: .flags)
		user = try values.decode(String.self, forKey: .user)
		mark = try values.decode(Int.self, forKey: .mark)
	}
}
