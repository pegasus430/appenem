import React from 'react';
import { render } from 'react-dom';

import createHistory from 'history/createBrowserHistory';
import thunkMiddleware from 'redux-thunk';
import { createStore, combineReducers, applyMiddleware } from 'redux';
import { Provider } from 'react-redux';
import { ConnectedRouter, routerReducer, routerMiddleware } from 'react-router-redux';

import App from './components/app/App';
import registerServiceWorker from './registerServiceWorker';
import './index.css';

import reducers from './reducers';
import { fetchUser } from './reducers/user';

const history = createHistory({ basename: '/app' });

const store = createStore(
  combineReducers({
    ...reducers,
    router: routerReducer
  }),
  window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__(applyMiddleware(
    routerMiddleware(history),
    thunkMiddleware
  ))
);

store.dispatch(fetchUser());

render(
  <Provider store={store}>
    <ConnectedRouter history={history}>
      <App />
    </ConnectedRouter>
  </Provider>,
  document.getElementById('root')
);
registerServiceWorker();
