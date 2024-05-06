$(function() {
    // $('ul.tab_area li').click(function(){
    //   var index = $('ul.tab_area li').index(this);
    //   $('.content_area').css('display','none');
    //   $('.content_area').eq(index).fadeIn();
    //   $('.tab_area li').removeClass('select');
    //   $(this).addClass('select');
    // });

    // var hash = location.hash;
    // hash = (hash.match(/^#tab_panel-\d+$/) || [])[0];
    // if ($(hash).length) {
    //     var tabname = hash.slice(1);
    // } else {
    //     var tabname = "tab_panel-1";
    // }
    // $(".tab_box .tab_btn").removeClass("active");
    // $(".tab_box .tab_panel").removeClass("active");
    // var tabno = $(".tab_box .tab_panel#" + tabname).index();
    // $(".tab_box .tab_panel").eq(tabno).addClass("active");
    // $(".tab_box .tab_btn").eq(tabno).addClass("active");
});

function tabtest() {
  debugger
  var url = location.href;
  url = (url.match(/\?no=tab\d+$/) || [])[0];
  var params = url.split("?");
  var tab = params[1].split("=");
  if($(tab).length){
    var tabname = tab[1];
  } else{
    var tabname = "tab1";
  }
  $('content_area').css('display','none');
  $('tab_area li').removeClass('active')
  var tabno = $('ul.tab_area li#' + tabname).index();
  $('.content_area').eq(tabno).fadeIn();
  $('ul.tab_area li').eq(tabno).addClass('active');
};