(() => {
    const pathMatch = location.search.match(/[?|&]path=([^&]+)/)
    const path = pathMatch ? pathMatch[1] : ''
    const changeNavActive = index => {
        $('.J-nav-card').eq(index).addClass('active')
    }
    if(/index\//.test(path)) {
        changeNavActive(0)
    }
    if(/judgingTool\//.test(path)) {
        changeNavActive(1)
    }
    if(/prevenModel\//.test(path)) {
        changeNavActive(2)
    }
    if(/case\//.test(path)) {
        changeNavActive(3)
    }
    if(/systemManage\//.test(path)) {
        changeNavActive(4)
    }
})()