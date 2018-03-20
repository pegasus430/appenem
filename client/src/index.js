import React from 'react';
import { render } from 'react-dom';

import createHistory from 'history/createBrowserHistory';
import thunkMiddleware from 'redux-thunk';
import { createStore, combineReducers, applyMiddleware, compose } from 'redux';
import { Provider } from 'react-redux';
import { ConnectedRouter, routerReducer, routerMiddleware } from 'react-router-redux';

import ReactGA from 'react-ga';

import { BoundApp } from './components/app';
import registerServiceWorker from './registerServiceWorker';
import './index.css';

import reducers from './reducers';
import { fetchUser } from './reducers/user';

ReactGA.initialize('UA-102026712-1');

const history = createHistory({ basename: '/app' });

history.listen((location) => {
  ReactGA.pageview('/app' + location.pathname);
});

ReactGA.pageview(window.location.pathname);

const store = createStore(
  combineReducers({
    ...reducers,
    router: routerReducer
  }),
  compose(applyMiddleware(
    routerMiddleware(history),
    thunkMiddleware
  ))
);

store.dispatch(fetchUser());

render(
  <Provider store={store}>
    <ConnectedRouter history={history}>
      <BoundApp />
    </ConnectedRouter>
  </Provider>,
  document.getElementById('root')
);
registerServiceWorker();
