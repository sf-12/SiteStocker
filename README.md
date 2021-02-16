# SiteStocker [![sf-12](https://circleci.com/gh/sf-12/SiteStocker.svg?style=shield)](https://app.circleci.com/pipelines/github/sf-12/SiteStocker) [![Maintainability](https://api.codeclimate.com/v1/badges/46c8c4a0be7ec7f6a636/maintainability)](https://codeclimate.com/github/sf-12/SiteStocker/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/46c8c4a0be7ec7f6a636/test_coverage)](https://codeclimate.com/github/sf-12/SiteStocker/test_coverage)


![サイト画像](https://user-images.githubusercontent.com/49280097/106329334-97832b00-62c4-11eb-8cd4-73f5a325478e.png)
<br>

![サイト画像-レスポンシブ](https://user-images.githubusercontent.com/49280097/106328658-88e84400-62c3-11eb-9d9b-3e50f664cd1c.png)
<br>

## サイト概要
おすすめのWebサイトを投稿できるSNSです。<br>
みんなの投稿を閲覧したり、自分で投稿したり、コメント欄で語り合ったりできます。<br>

### サイトテーマ
お気に入りのサイトを<br>
見つけよう 共有しよう 語り合おう<br>

### テーマを選んだ理由
ポートフォリオ作成のためにいろいろなWebサイトを閲覧していたら、<br>
いままで知らなかった便利なサイトや面白いサイトがたくさんあることに気づきました。<br>
もしWebサイトを紹介し合うことができるコミュニティがあったら、<br>
もっと面白くて便利なサイトを知ることができると思い、制作することにしました。<br>

### ターゲットユーザ
- 年齢：20代〜50代<br>
- 性別：男女問わない<br>
- ネットサーフィンをよくする人<br>
- お気に入り登録してあるWebサイトが多く、整理したいと思っている人<br>

### 主な利用シーン
- 便利なサイトや面白いサイトを探したいとき、紹介したいとき
- お気に入りのWebサイトが増えすぎて管理に困っているとき
- お気に入りのWebサイトにメモやタグをつけて管理したいとき<br>

## 機能一覧
- ユーザー側
  - 新規登録、退会、ログイン、ログアウト機能
  - マイページ閲覧、編集機能
  - 投稿、一覧表示、詳細表示、編集、削除機能
  - コメント機能、コメント削除機能
  - いいね機能
  - フォロー機能、フォロー・フォロワーの一覧表示機能
  - タグ機能
  - ランキング機能
  - 検索機能
- 管理者側
  - ログイン、ログアウト機能
  - ユーザーの一覧表示、詳細表示、編集機能
  - 投稿の一覧表示、詳細表示、編集機能
  - タグの一覧表示、詳細表示、編集機能
  - コメントの一覧表示、詳細表示、編集機能

その他詳細は[こちら](https://docs.google.com/spreadsheets/d/1ZBZLLgjB8m_0iXxOnhGBY6VyVq8xN-p1pnhqeyoahkU/edit?usp=sharing)をご覧ください。<br>

## 取り入れた技術
- 環境構築にDocker, Docker-Composeを使用
- RuboCopを用いて静的解析を実施
- RSpecでテストを実施
- Circle CIで自動テスト
- Capistranoで自動デプロイ
- 外部API ( LinkPreview ) を用いてプレビュー画像を取得
- CSVファイルでseedデータを管理(seed-fu)
- GitHub、Circle CI、Code Climateを連携し、コードの保守性とテストカバレッジを把握
- Circle CIとSlackを連携し、デプロイの成功/失敗を通知

## インフラ構成図
![インフラ構成図](https://user-images.githubusercontent.com/49280097/107325863-dba8d380-6aed-11eb-9155-ac1779cbfdb7.png)
<br>

## ER図
![ER図](https://user-images.githubusercontent.com/49280097/106114389-d913b900-6192-11eb-8132-cb5a117780e8.png)
<br>

## 開発環境
- OS：macOS Catalina<br>
  Docker / Docker-Compose
- 言語：HTML, CSS, JavaScript, Ruby, SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Visual Studio Code
