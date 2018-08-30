import React, { Component } from 'react'
import axios from 'axios'
import flatten from 'lodash/flatten'
import orderBy from 'lodash/orderBy'
import { sources, deserializeItems } from '../sources'

import Item from './item'

class Timeline extends Component {
  constructor() {
    super()

    this.state = {
      loading: true,
      sources: [],
      items: []
    }
  }

  fetchData() {
    return sources.map(({ name, url }) =>
      axios.get(url).then(({ data }) =>
        this.setState({
          sources: this.state.sources.concat(name),
          items: orderBy(
            flatten(this.state.items.concat(deserializeItems(data, name))),
            ['date'],
            ['desc']
          )
        })
      )
    )
  }

  componentDidMount() {
    Promise.all(this.fetchData()).then(() => this.setState({ loading: false }))
  }

  render() {
    const { items, filter, loading, sources } = this.state

    const filteredItems = filter
      ? items.filter(item => item.source === filter)
      : items

    return (
      <div className={['timeline', loading ? 'loading' : undefined].join(' ')}>
        <div className="timeline-filter">
          <button
            className={!filter && 'active'}
            onClick={() => this.setState({ filter: null })}>
            All
          </button>
          {sources.map(source => (
            <button
              className={filter === 'source' ? 'active' : undefined}
              key={source}
              onClick={() => this.setState({ filter: source })}>
              {source}
            </button>
          ))}
        </div>

        <div className="timeline-items">
          {filteredItems.map((item, key) => <Item key={key} {...item} />)}
        </div>
      </div>
    )
  }
}

export default Timeline
