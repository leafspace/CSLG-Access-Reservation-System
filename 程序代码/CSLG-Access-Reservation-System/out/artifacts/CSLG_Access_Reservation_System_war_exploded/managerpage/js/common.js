/**
 * a标签重写事件
 * @param _this 当前点击的对象
 * @param href  需要跳转的链接
 */
function copy(_this,href) {
    var flag = true;
    _this.onmousemove = function () {
        flag = false;
    };
    _this.onmouseup = function () {
        if(flag) return window.location.href = href;
        else  return false;
    };
}

