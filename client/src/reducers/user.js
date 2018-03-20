import api from '../api';

import { fetchSchool,
         fetchSchoolExcerpt,
         fetchSchoolComparison } from './school';

const REQUEST_USER = 'REQUEST_USER';
const RECEIVE_USER = 'RECEIVE_USER';
const CHANGE_EXAM = 'CHANGE_EXAM';
const CHANGE_AREA = 'CHANGE_AREA';
const CHANGE_GROUP = 'CHANGE_GROUP';
const CHANGE_SCHOOL = 'CHANGE_SCHOOL';
const RECEIVE_GROUP = 'RECEIVE_GROUP';
const DESTROY_GROUP = 'DESTROY_GROUP';
const SET_SPECIAL_SCHOOL = 'SET_SPECIAL_SCHOOL';

const requestUser = () => ({ type: REQUEST_USER });
const receiveUser = (user) => ({ type: RECEIVE_USER, user });
const changeArea = (area_id) => ({ type: CHANGE_AREA, area_id });
const changeExam = (exam_id) => ({ type: CHANGE_EXAM, exam_id });
const changeSchool = (school_id) => ({ type: CHANGE_SCHOOL, school_id });
const changeGroup = (group_id) => ({ type: CHANGE_GROUP, group_id });
const setSpecialSchool = (school) => ({ type: SET_SPECIAL_SCHOOL, school });
const receiveGroup = (group) => ({ type: RECEIVE_GROUP, group });
const destroyGroup = (group) => ({ type: DESTROY_GROUP, group });

const saveGroup = (group) => {
  return (dispatch) => {
    api.createGroup(group)
      .then(response => response.json(), error => console.log(error))
      .then(json => dispatch(receiveGroup(json)));
  };
};

const removeGroup = (group) => {
  return (dispatch) => {
      api.destroyGroup(group)
        .then(response => response.json(), error => console.log(error))
        .then(json => dispatch(destroyGroup(group)));
  };
};

const fetchUser = () => {
  return (dispatch) => {
    dispatch(requestUser())
    return api.getUser()
      .then((response) => {
        if (response.status === 200) {
          return response.json();
        } else {
          window.location.replace(window.location.origin);
        }
      }, error => ( window.location.replace(window.location.origin) ))
      .then(json => {
          dispatch(receiveUser(json));
          dispatch(fetchSchool());
          dispatch(fetchSchoolExcerpt());
          dispatch(fetchSchoolComparison());
      });
  };
};

export { fetchUser, changeArea, changeExam, changeSchool, changeGroup, saveGroup,
         removeGroup, setSpecialSchool };

const initialState = { isFetching: true };

const reducer = (state = initialState, action) => {
  switch(action.type) {
    case REQUEST_USER:
      return { isFetching: true };
    case RECEIVE_USER:
      return { isFetching: false, ...action.user };
    case CHANGE_AREA:
      return { ...state, area_id: action.area_id };
    case CHANGE_EXAM:
      return { ...state, exam_id: action.exam_id };
    case CHANGE_SCHOOL:
      let schools = state.specialSchool ?
                    [...state.schools, state.specialSchool] :
                    state.schools;
      let school = schools.filter(school => school.id === action.school_id)[0];
      return { ...state,
               school_id: action.school_id,
               exams: school.exams,
               exam_id: school.exams[school.exams.length - 1].id };
    case CHANGE_GROUP:
      return { ...state, group_id: action.group_id };
    case RECEIVE_GROUP:
      return { ...state, groups: [ ...state.groups, action.group ] };
    case DESTROY_GROUP:
      return {
        ...state,
        groups: state.groups.filter(group => group.id !== action.group.id) };
    case SET_SPECIAL_SCHOOL:
      return { ...state, specialSchool: action.school };
    default:
      return state;
  }
};

export default reducer;
