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