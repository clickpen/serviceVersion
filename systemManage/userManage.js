const systamManageObj = {
    init() {
        this.bind()
    },
    bind() {

    }
}
new Vue({
    el: '#systemManage',
    data: {
        systemManageTab: 'userManage'
    },
    mounted() {
        systamManageObj.init()
    }
})