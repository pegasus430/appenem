import api from '../api';

const REQUEST_SCHOOL = 'REQUEST_SCHOOL';
const RECEIVE_SCHOOL = 'RECEIVE_SCHOOL';
const REQUEST_SCHOOL_EXCERPT = 'REQUEST_SCHOOL_EXCERPT';
const RECEIVE_SCHOOL_EXCERPT = 'RECEIVE_SCHOOL_EXCERPT';
const REQUEST_SCHOOL_COMPARISON = 'REQUEST_SCHOOL_COMPARISON';
const RECEIVE_SCHOOL_COMPARISON = 'RECEIVE_SCHOOL_COMPARISON';
const REQUEST_SCHOOL_QUESTIONS = 'REQUEST_SCHOOL_QUESTIONS';
const RECEIVE_SCHOOL_QUESTIONS = 'RECEIVE_SCHOOL_QUESTIONS';
const REQUEST_SCHOOL_QUESTION = 'REQUEST_SCHOOL_QUESTION';
const RECEIVE_SCHOOL_QUESTION = 'RECEIVE_SCHOOL_QUESTION';
const REQUEST_SCHOOL_OVERVIEW_HEADER = 'REQUEST_SCHOOL_OVERVIEW_HEADER';
const RECEIVE_SCHOOL_OVERVIEW_HEADER = 'RECEIVE_SCHOOL_OVERVIEW_HEADER';
const REQUEST_SCHOOL_SUBJECTS = 'REQUEST_SCHOOL_SUBJECTS';
const RECEIVE_SCHOOL_SUBJECTS = 'RECEIVE_SCHOOL_SUBJECTS';
const REQUEST_SCHOOL_EVOLUTION = 'REQUEST_SCHOOL_EVOLUTION';
const RECEIVE_SCHOOL_EVOLUTION = 'RECEIVE_SCHOOL_EVOLUTION';
const REQUEST_SCHOOL_HISTOGRAM = 'REQUEST_SCHOOL_HISTOGRAM';
const RECEIVE_SCHOOL_HISTOGRAM = 'RECEIVE_SCHOOL_HISTOGRAM';
const REQUEST_SCHOOL_TAGS = 'REQUEST_SCHOOL_TAGS';
const RECEIVE_SCHOOL_TAGS = 'RECEIVE_SCHOOL_TAGS';
const REQUEST_SCHOOL_SKILLS = 'REQUEST_SCHOOL_SKILLS';
const RECEIVE_SCHOOL_SKILLS = 'RECEIVE_SCHOOL_SKILLS';

const CHANGE_AMPLITUDE = 'CHANGE_AMPLITUDE';

const requestSchool = () => ({ type: REQUEST_SCHOOL });
const receiveSchool = (school) => ({ type: RECEIVE_SCHOOL, school });
const requestSchoolExcerpt = (amplitude = 'city') => (
  { type: REQUEST_SCHOOL_EXCERPT, amplitude }
);
const receiveSchoolExcerpt = (excerpt) => ({ type: RECEIVE_SCHOOL_EXCERPT, excerpt });
const requestSchoolComparison = () => ({ type: REQUEST_SCHOOL_COMPARISON });
const receiveSchoolComparison = (comparison) => (
  { type: RECEIVE_SCHOOL_COMPARISON, comparison }
);
const requestSchoolQuestions = () => (
  { type: REQUEST_SCHOOL_QUESTIONS }
);
const receiveSchoolQuestions = (questions) => (
  { type: RECEIVE_SCHOOL_QUESTIONS, questions }
);

const requestSchoolQuestion = (id) => (
  { type: REQUEST_SCHOOL_QUESTION, id }
);
const receiveSchoolQuestion = (question) => (
  { type: RECEIVE_SCHOOL_QUESTION, question }
);
const requestSchoolOverviewHeader = () => (
  { type: REQUEST_SCHOOL_OVERVIEW_HEADER }
);
const receiveSchoolOverviewHeader = (overviewHeader) => (
  { type: RECEIVE_SCHOOL_OVERVIEW_HEADER, overviewHeader }
);
const requestSchoolSubjects = () => (
  { type: REQUEST_SCHOOL_SUBJECTS }
);
const receiveSchoolSubjects = (subjects) => (
  { type: RECEIVE_SCHOOL_SUBJECTS, subjects }
);
const requestSchoolEvolution = () => (
  { type: REQUEST_SCHOOL_EVOLUTION }
);
const receiveSchoolEvolution = (evolution) => (
  { type: RECEIVE_SCHOOL_EVOLUTION, evolution }
);
const requestSchoolHistogram = () => (
  { type: REQUEST_SCHOOL_HISTOGRAM }
);
const receiveSchoolHistogram = (histogram) => (
  { type: RECEIVE_SCHOOL_HISTOGRAM, histogram }
);
const requestSchoolTags = () => (
  { type: REQUEST_SCHOOL_TAGS }
);
const receiveSchoolTags = (tags) => (
  { type: RECEIVE_SCHOOL_TAGS, tags }
);
const requestSchoolSkills = () => (
  { type: REQUEST_SCHOOL_SKILLS }
);
const receiveSchoolSkills = (skills) => (
  { type: RECEIVE_SCHOOL_SKILLS, skills }
);


const fetchSchool = () => {
  return (dispatch, state) => {
    dispatch(requestSchool());
    let { school_id, exam_id } = state().user;
    return api.getSchool(school_id, exam_id)
      .then(response => response.json(), error => console.error(error))
      .then(json => dispatch(receiveSchool(json)));
  };
};

const fetchSchoolExcerpt = () => {
  return (dispatch, state) => {
    dispatch(requestSchoolExcerpt());
    let { school_id, exam_id } = state().user;
    let { amplitude } = state().school;
    return api.getSchoolExcerpt(school_id, exam_id, amplitude)
      .then(response => response.json(), error => console.error(error))
      .then(json => dispatch(receiveSchoolExcerpt(json)));
  };
};

const fetchSchoolComparison = () => {
  return (dispatch, state) => {
    dispatch(requestSchoolComparison());
    let { school_id, group_id } = state().user;
    let { amplitude } = state().school;
    return api.getSchoolComparison(school_id, group_id, amplitude)
      .then(response => response.json(), error => console.error(error))
      .then(json => dispatch(receiveSchoolComparison(json)));
  };
};

const fetchSchoolQuestions = () => {
  return (dispatch, state) => {
    dispatch(requestSchoolQuestions());
    let { school_id, area_id, exam_id, group_id } = state().user;
    return api.getSchoolQuestions(school_id, exam_id, area_id, group_id)
      .then(response => response.json(), error => console.log(error))
      .then(json => dispatch(receiveSchoolQuestions(json)));
  };
};

const fetchSchoolQuestion = (id) => {
  return (dispatch, state) => {
    dispatch(requestSchoolQuestion(id));
    let { school_id, exam_id, area_id, group_id } = state().user;
    return api.getSchoolQuestion(school_id, id, exam_id, area_id, group_id)
      .then(response => response.json(), error => console.log(error))
      .then(json => dispatch(receiveSchoolQuestion(json)));
  };
};

const fetchSchoolOverviewHeader = () => {
  return (dispatch, state) => {
    dispatch(requestSchoolOverviewHeader());
    let { school_id, exam_id, area_id, group_id } = state().user;
    return api.getSchoolOverviewHeader(school_id, exam_id, area_id, group_id)
      .then(response => response.json(), error => console.log(error))
      .then(json => dispatch(receiveSchoolOverviewHeader(json)));
  };
};

const fetchSchoolSubjects = () => {
  return (dispatch, state) => {
    dispatch(requestSchoolSubjects());
    let { school_id, exam_id, area_id, group_id } = state().user;
    return api.getSchoolSubjects(school_id, exam_id, area_id, group_id)
      .then(response => response.json(), error => console.log(error))
      .then(json => dispatch(receiveSchoolSubjects(json)));
  };
};

const fetchSchoolEvolution = () => {
  return (dispatch, state) => {
    dispatch(requestSchoolEvolution());
    let { school_id, area_id, group_id } = state().user;
    return api.getSchoolEvolution(school_id, area_id, group_id)
      .then(response => response.json(), error => console.log(error))
      .then(json => dispatch(receiveSchoolEvolution(json)));
  };
};

const fetchSchoolHistogram = () => {
  return (dispatch, state) => {
    dispatch(requestSchoolHistogram());
    let { school_id, exam_id, area_id, group_id } = state().user;
    return api.getSchoolHistogram(school_id, exam_id, area_id, group_id)
      .then(response => response.json(), error => console.log(error))
      .then(json => dispatch(receiveSchoolHistogram(json)));
  };
};

const fetchSchoolTags = () => {
  return (dispatch, state) => {
    dispatch(requestSchoolTags());
    let { school_id, exam_id, area_id, group_id } = state().user;
    return api.getSchoolTags(school_id, exam_id, area_id, group_id)
      .then(response => response.json(), error => console.log(error))
      .then(json => dispatch(receiveSchoolTags(json)));
  };
};

const fetchSchoolSkills = () => {
  return (dispatch, state) => {
    dispatch(requestSchoolSkills());
    let { school_id, exam_id, area_id, group_id } = state().user;
    return api.getSchoolSkills(school_id, exam_id, area_id, group_id)
      .then(response => response.json(), error => console.log(error))
      .then(json => dispatch(receiveSchoolSkills(json)));
  };
};

const changeAmplitude = (amplitude) => {
  return (dispatch, state) => {
    if (state().school.amplitude === amplitude) return;

    dispatch({ type: CHANGE_AMPLITUDE, amplitude });
    dispatch(fetchSchoolExcerpt());
    dispatch(fetchSchoolComparison());
  };
};

export { fetchSchool,
         fetchSchoolExcerpt,
         fetchSchoolComparison,
         fetchSchoolQuestion,
         fetchSchoolQuestions,
         fetchSchoolOverviewHeader,
         fetchSchoolSubjects,
         fetchSchoolEvolution,
         fetchSchoolHistogram,
         fetchSchoolTags,
         fetchSchoolSkills,
         changeAmplitude };

const initialState = {
  amplitude: 'city',
  summary: {
    isFetching: true
  },
  excerpt: {
    isFetching: true
  },
  comparison: {
    isFetching: true
  },
  questions: {
    isFetching: true,
    values: [],
    selected: {
      isFetching: true
    }
  },
  overviewHeader: {
    isFetching: true
  },
  subjects: {
    isFetching: true,
    values: []
  },
  evolution: {
    isFetching: true
  },
  histogram: {
    isFetching: true
  },
  tags: {
    isFetching: true,
    values: []
  },
  skills: {
    isFetching: true,
    values: []
  }
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case REQUEST_SCHOOL:
      return { ...state, summary: { isFetching: true } };
    case RECEIVE_SCHOOL:
      return { ...state, summary: { isFetching: false, ...action.school } };
    case REQUEST_SCHOOL_EXCERPT:
      return { ...state, excerpt: { isFetching: true } };
    case RECEIVE_SCHOOL_EXCERPT:
      return { ...state, excerpt: { isFetching: false, ...action.excerpt } };
    case REQUEST_SCHOOL_COMPARISON:
      return { ...state, comparison: { isFetching: true } };
    case RECEIVE_SCHOOL_COMPARISON:
      return { ...state, comparison: { isFetching: false, ...action.comparison } };
    case REQUEST_SCHOOL_QUESTIONS:
      return { ...state, questions: { ...state.questions, isFetching: true, values: [] } };
    case RECEIVE_SCHOOL_QUESTIONS:
      return { ...state, questions: { ...state.questions, isFetching: false, values: action.questions } };
    case REQUEST_SCHOOL_QUESTION:
      return { ...state, questions: { ...state.questions, selected: { isFetching: true, id: action.id } } };
    case RECEIVE_SCHOOL_QUESTION:
      return { ...state, questions: { ...state.questions, selected: { isFetching: false, ...action.question } } };
    case REQUEST_SCHOOL_OVERVIEW_HEADER:
      return { ...state, overviewHeader: { isFetching: true } };
    case RECEIVE_SCHOOL_OVERVIEW_HEADER:
      return { ...state, overviewHeader: { isFetching: false, ...action.overviewHeader } };
    case REQUEST_SCHOOL_SUBJECTS:
      return { ...state, subjects: { isFetching: true, values: [] } };
    case RECEIVE_SCHOOL_SUBJECTS:
      return { ...state, subjects: { isFetching: false, values: action.subjects } };
    case REQUEST_SCHOOL_EVOLUTION:
      return { ...state, evolution: { isFetching: true } };
    case RECEIVE_SCHOOL_EVOLUTION:
      return { ...state, evolution: { isFetching: false, ...action.evolution } };
    case REQUEST_SCHOOL_HISTOGRAM:
      return { ...state, histogram: { isFetching: true } };
    case RECEIVE_SCHOOL_HISTOGRAM:
      return { ...state, histogram: { isFetching: false, ...action.histogram } };
    case REQUEST_SCHOOL_TAGS:
      return { ...state, tags: { isFetching: true, values: [] } };
    case RECEIVE_SCHOOL_TAGS:
      return { ...state, tags: { isFetching: false, values: action.tags } };
    case REQUEST_SCHOOL_SKILLS:
      return { ...state, skills: { isFetching: true, values: [] } };
    case RECEIVE_SCHOOL_SKILLS:
      return { ...state, skills: { isFetching: false, values: action.skills } };
    case CHANGE_AMPLITUDE:
      return { ...state, amplitude: action.amplitude };
    default:
      return state;
  }
};

export default reducer;
