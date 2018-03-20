import React from 'react';
import { AppBar, NavDrawer, Panel, Layout, Navigation,
         Button } from 'react-toolbox';
import { Route } from 'react-router';

import { BoundExamSelector } from '../exam_selector';
import { BoundGroupSelector } from '../group_selector';
import { BoundSchoolSelector } from '../school_selector';
import { BoundMenu } from '../menu';
import { Icon } from '../icon';
import { HomePage, BoundAreaPage, RankingPage, GroupPage } from '../pages/';
import { BoundCrispLoader } from '../crisp_loader/';
import ContentLoader from '../content_loader';

import styles from './App.css';

const App = () => (
  <Layout>
    <AppBar fixed primary>
      <Icon name='logotype' />
      <span> Resultados ENEM</span>
      <Navigation type='horizontal' className={ styles.navigation }>
        <BoundSchoolSelector />
        <BoundGroupSelector />
        <BoundExamSelector />
        <Button theme={ styles } onClick={
            () => {
              localStorage.removeItem('credentials');
              window.location.replace(window.location.origin);
            }
          } label="Sair" />
      </Navigation>
    </AppBar>

    <NavDrawer active clipped pinned>
      <BoundMenu />
    </NavDrawer>

    <Panel>
      <Route exact path='/' component={ HomePage } />
      <Route path='/area/:area_id' component={ BoundAreaPage } />
      <Route path='/ranking' component={ RankingPage } />
      <Route path='/groups' component={ GroupPage } />
    </Panel>
    <BoundCrispLoader />
  </Layout>
);

export default ContentLoader()(App);
