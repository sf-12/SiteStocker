$(function(){

  // 環境変数からAPI＿KEYを取得
  const API_KEY = gon.linkpreview_key;
  // 投稿IDの一覧を取得
  const TWEET_ID_LIST = gon.tweet_id_list;
  // 追加リクエストの設定 (site_name:サイト名)
  const FIELDS = 'site_name';

  // 投稿IDの数だけAPIを叩く
  TWEET_ID_LIST.forEach(function(elem) {

    // 投稿IDを頼りに、サイトurlをviewから取得
    site_url = $('#site_url_js' + elem).val();
    console.log('サイトURL:' + site_url)
    console.log('elem:' + elem)
    // サイト情報の取得に必要なパラメータをセット
    var data = {key: API_KEY, fields: FIELDS, q: site_url}

    // サイト情報の取得 & htmlへ埋め込み
    fetch('https://api.linkpreview.net', {
      method: 'POST',
      mode: 'cors',
      body: JSON.stringify(data),
    })
    .then(res => res.json())
    .then(response => {
      document.getElementById('myimage_js' + elem ).src = response.image
      document.getElementById('mytitle_js' + elem ).innerHTML = response.title
      document.getElementById('mydescription_js' + elem ).innerHTML = response.description
      document.getElementById('myurl_js' + elem ).innerHTML = response.url
      document.getElementById('mysitename_js' + elem ).innerHTML = response.site_name
    })
    // ログ出力
    console.log('投稿ID' + elem + '---サイトURL:' + site_url)
  });
});
