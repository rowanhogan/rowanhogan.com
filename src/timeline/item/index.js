import React from 'react'
import moment from 'moment'

const Item = ({ date, image, source, title, url }) => (
  <div className={['timeline-item', source].join(' ')}>
    <header>
      <a className="timeline-item-source" href={url} target="_blank">
        {source}
      </a>
      <span className="timeline-item-date">{moment(date).format('LL')}</span>
    </header>
    {image && (
      <a
        href={url}
        target="_blank"
        className="timeline-item-image"
        style={{ backgroundImage: `url(${image})` }}
      />
    )}
    <footer>{title}</footer>
  </div>
)

export default Item
