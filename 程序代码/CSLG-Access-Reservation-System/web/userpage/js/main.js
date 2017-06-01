var orderID = document.getElementById('orderID');
var orderID_1 = document.getElementById('orderID_1');
var orderID_2 = document.getElementById('orderID_2');
var orderID_3 = document.getElementById('orderID_3');
var orderID_4 = document.getElementById('orderID_4');
var pullDown = document.getElementsByClassName('pullDown')[0];
var pullDown_1 = document.getElementsByClassName('pullDown')[1];
var pullDown_2 = document.getElementsByClassName('pullDown')[2];
var pullDown_3 = document.getElementsByClassName('pullDown')[3];
var pullDown_4 = document.getElementsByClassName('pullDown')[4];

orderID.onclick = function() {
	(pullDown.style.display == 'block') ? pullDown.style.display = 'none' : pullDown.style.display = 'block';
}
orderID_1.onclick = function() {
	(pullDown_1.style.display == 'block') ? pullDown_1.style.display = 'none' : pullDown_1.style.display = 'block';
}
orderID_2.onclick = function() {
	(pullDown_2.style.display == 'block') ? pullDown_2.style.display = 'none' : pullDown_2.style.display = 'block';
}
orderID_3.onclick = function() {
	(pullDown_3.style.display == 'block') ? pullDown_3.style.display = 'none' : pullDown_3.style.display = 'block';
}
orderID_4.onclick = function() {
	(pullDown_4.style.display == 'block') ? pullDown_4.style.display = 'none' : pullDown_4.style.display = 'block';
}
window.onresize = function(){
	document.body.innerHeight = window.innerHeight;
}

!(function(doc, win) {
	var docEle = doc.documentElement,
	evt = "onorientationchange" in window ? "orientationchange" : "resize",
	fn = function() {
		var width = docEle.clientWidth;
		if(width > 1024){
			width && (docEle.style.fontSize = width/120 + "px");
		}
	};
	win.addEventListener(evt, function(){
		fn();
		setTimeout(fn,50);
	}, false);
	doc.addEventListener("DOMContentLoaded", function(){
		fn();
		setTimeout(fn,50);
	}, false);
}(document, window));

var num = 0;
var month = document.getElementById('month');
month.onkeyup = function (){
	if (this.value < 1 || this.value > 12) {
		this.value = 12;
	}
}
var date = document.getElementById('date');
date.onkeyup = function (){
	if (this.value < 1 || this.value > 31) {
		this.value = 1;
	}
}

var year = document.getElementById('year'),
	month = document.getElementById('month'),
	date = document.getElementById('date'),
	time = document.getElementById('time'),
	endtime = document.getElementById('endtime');

document.getElementById('JS_submite').onclick = function(){
	if( !/^[0-9]*[1-9][0-9]*$/.test( year.value ) ){
		alert('请输入正确的年份!');
		return false;
	}else if( !/^[0-9]*[1-9][0-9]*$/.test( month.value ) ){
		alert('请输入正确的月份!');
		return false;
	}else if( !/^[0-9]*[1-9][0-9]*$/.test( date.value ) ){
		alert('请输入正确的日期!');
		return false;
	}
	if( time.value == '' || endtime.value == '' ){
		alert('请输填写时间!');
		return false;
	}

}