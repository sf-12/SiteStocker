// モーダルウィンドウ

// 検索機能================================================

// タブレット
// ウィンドウを表示
$('#search_button_js').click(function(){
  $('#search_cover_js, #search_modal_js').fadeTo(200,1);
  console.log('ウィンドウを表示');
});
// ウィンドウを閉じる
$('#search_close_js, #search_cover_js').click(function(){
  $('#search_cover_js, #search_modal_js').fadeTo(200,0).hide();
});

// スマホ
// ウィンドウを表示
$('#search_button_phone_js').click(function(){
  $('#search_cover_phone_js, #search_modal_phone_js').fadeTo(200,1);
  console.log('ウィンドウを表示');
});
// ウィンドウを閉じる
$('#search_close_phone_js, #search_cover_phone_js').click(function(){
  $('#search_cover_phone_js, #search_modal_phone_js').fadeTo(200,0).hide();
});

// 投稿機能================================================

// PC・タブレット
// ウィンドウを表示
$('#tweet_button_js').click(function(){
  $('#tweet_cover_js, #tweet_modal_js').fadeTo(200,1);
});
// ウィンドウを閉じる
$('#tweet_close_js, #tweet_cover_js').click(function(){
  $('#tweet_cover_js, #tweet_modal_js').fadeTo(200,0).hide();
});

// スマホ
// ウィンドウを表示
$('#tweet_button_phone_js').click(function(){
  $('#tweet_cover_phone_js, #tweet_modal_phone_js').fadeTo(200,1);
});
// ウィンドウを閉じる
$('#tweet_close_phone_js, #tweet_cover_phone_js').click(function(){
  $('#tweet_cover_phone_js, #tweet_modal_phone_js').fadeTo(200,0).hide();
});
