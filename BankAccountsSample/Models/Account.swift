/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Account : Codable, Identifiable {
	let order : Int?
	let id : String?
	let holder : String?
	let role : Int?
	let contract_number : String?
	let label : String?
	let product_code : String?
	let balance : Double?
	let operations : [Operation]?

	enum CodingKeys: String, CodingKey {

		case order = "order"
		case id = "id"
		case holder = "holder"
		case role = "role"
		case contract_number = "contract_number"
		case label = "label"
		case product_code = "product_code"
		case balance = "balance"
		case operations = "operations"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		order = try values.decodeIfPresent(Int.self, forKey: .order)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		holder = try values.decodeIfPresent(String.self, forKey: .holder)
		role = try values.decodeIfPresent(Int.self, forKey: .role)
		contract_number = try values.decodeIfPresent(String.self, forKey: .contract_number)
		label = try values.decodeIfPresent(String.self, forKey: .label)
		product_code = try values.decodeIfPresent(String.self, forKey: .product_code)
		balance = try values.decodeIfPresent(Double.self, forKey: .balance)
		operations = try values.decodeIfPresent([Operation].self, forKey: .operations)
	}

}
