// ページ更新でtag-it発火
$(document).ready(function() {
  $('.tag_form_js').tagit({  // 指定のセレクタに、tag-itを反映
    tagLimit:5,         // タグの最大数
    singleField: true,   // タグの一意性
  });
})
