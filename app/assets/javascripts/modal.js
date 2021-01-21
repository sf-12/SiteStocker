// モーダルウィンドウ

// 検索機能------------------------------------------------
// ウィンドウを表示
$('#search_button_js').click(function(){
  $('#search_cover_js, #search_modal_js').fadeTo(200,1);
});
// ウィンドウを閉じる
$('#search_close_js, #search_cover_js').click(function(){
  $('#search_cover_js, #search_modal_js').fadeTo(200,0).hide();
});
// 投稿機能------------------------------------------------
// ウィンドウを表示
$('#tweet_button_js').click(function(){
  $('#tweet_cover_js, #tweet_modal_js').fadeTo(200,1);
});
// ウィンドウを閉じる
$('#tweet_close_js, #tweet_cover_js').click(function(){
  $('#tweet_cover_js, #tweet_modal_js').fadeTo(200,0).hide();
});
