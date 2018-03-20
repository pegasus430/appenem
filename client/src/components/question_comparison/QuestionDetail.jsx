import React from 'react';
import { Chip } from 'react-toolbox';
import ContentLoader from '../content_loader';
import AlternativeChart from './AlternativeChart';

import styles from './QuestionDetail.css';

const QuestionDetail = ({label, content, subject, skill, tags, alternatives}) => (
  <div>
    <h1>Questão {label}</h1>
    <div>
      <Chip>{ subject.name }</Chip>
      <Chip>{ skill.label }</Chip>
      { tags.map((tag, index) => (<Chip key={ index }>{ tag.name }</Chip>)) }
    </div>
    <div dangerouslySetInnerHTML={{__html: content }}></div>
    <div className={ styles.container }>
      <div>
        <AlternativeChart alternatives={alternatives} />
      </div>
      <div className={ styles.alternatives }>
        { alternatives.map((alternative, index) => (
          <div key={ index }
               className={ alternative.correct ?
                           styles.correct :
                           styles.alternative }>
            <div className={ styles.label }>{ alternative.label }</div>
            <div className={ styles.content }
                 dangerouslySetInnerHTML={ {__html: alternative.content} } />
          </div>
        ))}
      </div>
    </div>
  </div>
);

export default ContentLoader()(QuestionDetail);
