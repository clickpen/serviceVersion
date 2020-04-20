/**
 * 格式化时间
 * @param time Number|String|TimeObj    数字、字符串类型10、13-17位的时间戳，或者已经格式化的时间字符串，以及时间对象字符串，或者时间对象
 * @param type String   格式：yy-MM-dd|yy-MM-dd hh:mm|yy-MM-dd hh:mm:ss
 * @return String|Number 返回格式化时间或者时间戳
 */
function formatTime(time, type) {
    if (!time) {
        return ''
    }
    let tp = typeof (time)
    // 字符串类型时间戳
    if (tp === 'string' && (parseInt(time) + '').length === time.length) {
        if (time.length === 10) {
            time *= 1000
        } else if (time.length >= 13 && time.length < 17) {
            time = parseInt(time)
        } else {
            return 'can`t format this time: "' + time + '"'
        }
        // 数字类型时间戳
    } else if (tp === 'number') {
        if ((time + '').length === 10) {
            time *= 1000
        } else if ((time + '').length < 13 || (time + '').length >= 17) {
            return 'can`t format this time: "' + time + '"'
        }
        // 已经格式化的字符串但不能识别或者时间对象不能识别时
    } else if (new Date(time).toString() === 'Invalid Date') {
        return 'can`t format this time: "' + time + '"'
    }
    let _date = new Date(time),
        Y = _date.getFullYear(),
        M = _date.getMonth() + 1,
        D = _date.getDate(),
        h = _date.getHours(),
        m = _date.getMinutes(),
        s = _date.getSeconds()
    M = M < 10 ? '0' + M : M
    D = D < 10 ? '0' + D : D
    h = h < 10 ? '0' + h : h
    m = m < 10 ? '0' + m : m
    s = s < 10 ? '0' + s : s
    if (type) {
        return type.replace('yy', Y).replace('MM', M).replace('dd', D).replace('hh', h).replace('mm', m).replace('ss', s)
    } else {
        return _date
    }
}
/**
 * 调用语音系统
 * @param text String 需要读的内容
 */
function myReadText(text) {
    if(!speechSynthesis) {
        return console.log('当前浏览器不支持语音读取内容！')
    }
    let synth = speechSynthesis
    let options = new SpeechSynthesisUtterance()
    // 配置项参数说明：
    // text – 要合成的文字内容，字符串。
    // lang – 使用的语言，字符串， 例如："zh-cn"
    // voiceURI – 指定希望使用的声音和服务，字符串。
    // volume – 声音的音量，区间范围是0到1，默认是1。
    // rate – 语速，数值，默认值是1，范围是0.1到10，表示语速的倍数，例如2表示正常语速的两倍。
    // pitch – 表示说话的音高，数值，范围从0（最小）到2（最大）。默认值为1。
    // 回调函数：
    // onstart – 语音合成开始时候的回调。
    // onpause – 语音合成暂停时候的回调。
    // onresume – 语音合成重新开始时候的回调。
    // onend – 语音合成结束时候的回调。
    options.lang = 'zh-CN'
    options.rate = 1
    options.text = text
    synth.speak(options)
}