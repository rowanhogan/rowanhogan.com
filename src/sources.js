import React from 'react'

export const sources = [
  {
    name: 'dribbble',
    url:
      'https://api.dribbble.com/v2/user/shots?access_token=adfa4877418a73562828b200ee636c713a56efc6efbd7f7f15da04491ddc421e'
  },
  {
    name: 'github',
    url: 'https://api.github.com/users/rowanhogan/events/public'
  },
  {
    name: 'instagram',
    url:
      'https://api.instagram.com/v1/users/682546/media/recent/?access_token=682546.39227a9.f064d732a280450093e7e568e874c7d4'
  },
  {
    name: 'lastfm',
    url:
      'https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=rehogan&api_key=ef147845c58771a584366acb1089d962&format=json'
  }
]

export const deserializeItems = (data, source) => {
  switch (source) {
    case 'dribbble':
      return data.map(item => ({
        source,
        date: new Date(item.published_at).getTime(),
        image: item.images.hidpi || item.images.normal,
        title: item.title,
        url: item.html_url
      }))
    case 'github':
      return data
        .filter(
          ({ type }) => ['PullRequestEvent', 'PushEvent'].indexOf(type) > -1
        )
        .map(item => {
          const isPR = item.type === 'PullRequestEvent'
          const repoUrl = `https://github.com/${item.repo.name}`

          return {
            source,
            date: new Date(item.created_at).getTime(),
            title: (
              <div>
                <a href={item.actor.url} target="_blank">
                  {item.actor.login}
                </a>{' '}
                {isPR ? (
                  <span>
                    created pull request{' '}
                    <a
                      href={item.payload.pull_request.html_url}
                      target="_blank">
                      #{item.payload.number}
                    </a>{' '}
                    for
                  </span>
                ) : (
                  'pushed to'
                )}{' '}
                <a href={repoUrl}>{item.repo.name}</a>
              </div>
            ),
            url: isPR ? item.payload.pull_request.html_url : repoUrl
          }
        })
    case 'instagram':
      return data.data.map(item => ({
        source,
        date: parseInt(item.created_time) * 1000,
        image: item.images.standard_resolution.url,
        title: item.location.name,
        url: item.link
      }))
    case 'lastfm':
      return data.recenttracks.track.map(item => ({
        source,
        date: parseInt(item.date.uts) * 1000,
        image: item.image.find(({ size }) => size === 'extralarge')['#text'],
        title: (
          <span>
            <strong>{item.artist['#text']}</strong> - {item.name}
          </span>
        ),
        url: item.url
      }))
    default:
      return []
  }
}
