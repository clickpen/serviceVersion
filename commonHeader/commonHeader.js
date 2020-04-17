(() => {
    const pathMatch = location.search.match(/[?|&]path=([^&]+)/)
    const path = pathMatch ? pathMatch[1] : ''
    const changeNavActive = type => {
        $('.J-nav-card[name="' + type + '"]').addClass('active')
    }
    if(!path) {
        const _link = $('.J-nav-card').eq(0).find('a').attr('href')
        if(_link) {
            window.location.href = _link
        }
    }
    if (/index\//.test(path)) {
        changeNavActive('index')
    }
    if (/judgingTool\//.test(path)) {
        changeNavActive('judgingTool')
    }
    if (/prevenModel\//.test(path)) {
        changeNavActive('prevenModel')
    }
    if (/case\//.test(path)) {
        changeNavActive('case')
    }
    if (/systemModel\//.test(path)) {
        changeNavActive('systemModel')
    }
    $('.J-quit-login').on('click', function() {
        $.ajax({
            url: 'logout',
            type: 'post',
            success() {
                location.href = 'login'
            },
            error() {
                console.log('退出登录失败了')
            }
        })
    })
})()
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
    options.lang = 'zh-CN'
    options.rate = 1
    options.text = text
    synth.speak(options)
}