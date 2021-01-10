// $(function () {
document.addEventListener("turbolinks:load", function () {

  // 環境変数からAPI＿KEYを取得
  const API_KEY = gon.linkpreview_key;
  // 投稿IDの一覧を取得
  const TWEET_ID_LIST = gon.tweet_id_list;
  // 追加リクエストの設定 (site_name:サイト名)
  const FIELDS = 'site_name';

  // 投稿IDの数だけAPIを叩く
  TWEET_ID_LIST.forEach(function (elem) {

    // 投稿IDを頼りに、サイトurlをviewから取得
    // 料金節約のため、普段はAPIを叩かない
    // site_url = $('#site_url_js' + elem).val();
    site_url = undefined;

    // ログ出力
    console.log('サイトURL:' + site_url);

    // サイトURLが入っていることを確認してAPIを叩く
    if (site_url != undefined) {

      // サイト情報の取得に必要なパラメータをセット
      var data = { key: API_KEY, fields: FIELDS, q: site_url };

      // サイト情報の取得 & htmlへ埋め込み
      fetch('https://api.linkpreview.net', {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify(data),
      })
        .then(res => res.json())
        .then(response => {
          // ページタイトル
          document.getElementById('mytitle_js' + elem).innerHTML = response.title
          // ページ概要
          // document.getElementById('mydescription_js' + elem).innerHTML = response.description
          // サイト画像
          document.getElementById('myimage_js' + elem).src = response.image
          // ページ URL
          document.getElementById('myurl_js' + elem).innerHTML = response.url
          // サイトURL
          // document.getElementById('mysitename_js' + elem ).innerHTML = response.site_name
          // ログ出力
          console.log(JSON.stringify(response, null, 2));
        })
        .catch(response => {
          console.log('LinkPreviewAPIにアクセスしましたが、失敗しました');
        })
    } else {
      document.getElementById('myimage_js' + elem).src = 'noimage.png'
      // document.getElementById('mytitle_js' + elem).innerHTML = 'ページタイトル(取得不可)'
      document.getElementById('mytitle_js' + elem).innerHTML = 'ページタイトルページタイトルページタイトルページタイトルページタイトル'
      // document.getElementById('mydescription_js' + elem).innerHTML = 'ページ概要（取得不可）'
      // document.getElementById('myurl_js' + elem).innerHTML = 'ページURL（取得不可）'
      document.getElementById('myurl_js' + elem).innerHTML = 'ページURLページURLページURLページURLページURLページURLページURL'
      // document.getElementById('mysitename_js' + elem ).innerHTML = 'サイトURL（取得不可）'
      // ログ出力
      console.log('site_urlがundefinedだったため、LinkPreviewAPIにアクセスしませんでした');
    }
    // ログ出力
    console.log('投稿ID' + elem + '---サイトURL:' + site_url);
  });
});
