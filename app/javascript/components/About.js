import React from "react"
import { Link } from 'react-router-dom'

class About extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div class='about__content'>
          <div class='about__content-title'>見つけよう</div>
          <div class='about__content-text'>皆さんのおすすめのサイトを見ることができます</div>
        </div>

        <div class='about__content'>
          <div class='about__content-title'>共有しよう</div>
          <div class='about__content-text'>自分のおすすめのサイトを投稿できます</div>
        </div>

        <div class='about__content'>
          <div class='about__content-title'>語り合おう</div>
          <div class='about__content-text'>コメント欄で語り合うことができます</div>
        </div>
      </React.Fragment>
    );
  }
}

export default About
