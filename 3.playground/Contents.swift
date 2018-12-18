//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//1.显示北京、东京、纽约、伦敦当前准确的中文时间，格式为（2016年9月28日星期三 上午10:25）
//date 日期和时间
//zone 时区（东半球为正）
//result 返回指定格式的字符串
func getDate(date: Date, zone: Int = 0) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy年MM月dd日EEEE aa KK:mm"
    formatter.locale = Locale.current
    if zone >= 0{
        formatter.timeZone = TimeZone(abbreviation: "UTC+\(zone):00")
    }else{
        formatter.timeZone = TimeZone(abbreviation: "UTC\(zone):00")
    }
    
    let dateString = formatter.string(from: now)
    return dateString
}

let now = Date()

let beijing  = getDate(date: now, zone: +8)
print("北京: \(beijing)")

let tokyo = getDate(date: now, zone: 9)
print("东京: \(tokyo)")

let newyork  = getDate(date: now, zone: -5)
print("纽约: \(newyork)")

let london = getDate(date: now)
print("伦敦: \(london)")







//2.
let a = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS."
let b = a.replacingOccurrences(of: "OS", with: "")
print(b)




// 3.
let dictionary = ["date": ["beijing": beijing, "tokyo": tokyo, "newYork": newyork, "london": london], "string": b] as AnyObject

let defaultDoc = FileManager.default

if var path = defaultDoc.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
    path.append("/test.txt")
    
    print(dictionary.write(toFile: path, atomically: true))
}

// MARK: 4.
let image = try Data(contentsOf: URL(string: "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png")!)

if var url = defaultDoc.urls(for: .documentDirectory, in: .userDomainMask).first {
    url.appendPathComponent("image.png")
    try image.write(to: url)
}



//5.
let url = URL(string: "http://www.weather.com.cn/data/sk/101110101.html")! //api的路径
//let str = try String(contentsOf: url)
//print(str)  //显示json数据内容
let data = try Data(contentsOf: url)  //将json转换为二进制数据
let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)  //序列化json

//解析json数据
if let dic = json as? [String: Any] {
    if let weather = dic["weatherinfo"] as? [String: Any] {
        let city = weather["city"]!
        let temp = weather["temp"]!
        let wd = weather["WD"]!
        let ws = weather["WS"]!
        print("城市: \(city), 温度: \(temp), 风向: \(wd), 风力: \(ws)")
        //输出: 城市: 西安, 温度: 20, 风向: 西南风, 风力: 1级
    }
}

