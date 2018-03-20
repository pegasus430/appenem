const initialState = [
  { id: 5, name: 'Ciências Humanas', icon: 'public' },
  { id: 6, name: 'Ciências da Natureza', icon: 'local_florist' },
  { id: 7, name: 'Linguagens e códigos', icon: 'forum' },
  { id: 8, name: 'Matemática', icon: 'all_inclusive' }
];

const areas = (state = initialState, _) => (state);

export default areas;
