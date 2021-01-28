document.addEventListener("DOMContentLoaded", function () {
  // 環境変数からAPI＿KEYを取得
  const API_KEY = gon.linkpreview_key;

  // controllerから投稿IDの一覧を取得
  const TWEET_ID_LIST = gon.tweet_id_list;
  console.log('TWEET_ID_LIST: ' + TWEET_ID_LIST);

  // 追加リクエストの設定 (site_name:サイト名)
  const FIELDS = 'site_name';

  // 投稿IDの数だけAPIを叩く
  TWEET_ID_LIST.forEach(function (elem) {

    // 投稿IDを頼りに、サイトurlをviewから取得
    // 料金節約のため、普段はAPIを叩かない
    const SITE_URL = document.getElementById('site_url_js' + elem).value;
    // const SITE_URL = undefined;
    console.log('サイトURL: ' + SITE_URL);

    // サイトURLが入っていることを確認してAPIを叩く
    if (SITE_URL != undefined) {

      // サイト情報の取得に必要なパラメータをセット
      const DATA = { key: API_KEY, fields: FIELDS, q: SITE_URL };

      // サイト情報の取得 & htmlへ埋め込み
      fetch('https://api.linkpreview.net', {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify(DATA),
      })
        .then(res => res.json())
        .then(response => {
          console.log('response' + response);
          // ページタイトル
          document.getElementById('lp_title_js' + elem).innerHTML = response.title
          // ページ概要
          // document.getElementById('mydescription_js' + elem).innerHTML = response.description
          // サイト画像
          document.getElementById('lp_image_js' + elem).src = response.image
          // ページ URL
          // document.getElementById('myurl_js' + elem).innerHTML = response.url
          // サイトURL
          // document.getElementById('mysitename_js' + elem ).innerHTML = response.site_name
          // ログ出力
          console.log(JSON.stringify(response, null, 2));
        })
        .catch(response => {
          console.log('LinkPreviewAPIにアクセスしましたが、失敗しました');
        })
    } else {
      document.getElementById('lp_image_js' + elem).src = '/no-image.png'
      document.getElementById('lp_title_js' + elem).innerHTML = 'ページタイトル(取得できませんでした)'
      console.log('site_urlがundefinedだったため、LinkPreviewAPIにアクセスしませんでした');
    }
  });
});
