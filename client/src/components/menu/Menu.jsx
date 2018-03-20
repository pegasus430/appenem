import React from 'react';
import PropTypes from 'prop-types';
import { List, ListItem, ListDivider, ListSubHeader } from 'react-toolbox/lib/list/';

import StyledNavLink from './StyledNavLink';

const Menu = ({ areas }) => (
  <List selectable ripple>
    <StyledNavLink exact to="/">
      <ListItem leftIcon='home' caption='Minha Escola' />
    </StyledNavLink>

    <ListSubHeader caption='Grandes Áreas' />

    { areas.map(area => (
      <StyledNavLink key={area.id} to={`/area/${area.id}`}>
        <ListItem leftIcon={area.icon} caption={area.name} />
      </StyledNavLink>
    ))}

    <ListSubHeader caption='Configurações' />

    <StyledNavLink exact to="/groups">
      <ListItem leftIcon='group_work' caption='Grupos' />
    </StyledNavLink>

  </List>
);

/*
<ListDivider/>

<StyledNavLink to="/ranking">
  <ListItem leftIcon='poll' caption='Ranking do ENEM' />
</StyledNavLink>
*/

Menu.propTypes = {
  areas: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      name: PropTypes.string.isRequired,
      icon: PropTypes.string.isRequired
    }).isRequired
  ).isRequired
};

export default Menu;
