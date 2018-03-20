import fetch from 'isomorphic-fetch';

var auth_header = JSON.parse(localStorage.getItem('credentials'));

if (auth_header === null) {
  window.location.replace(window.location.origin);
}

const getUser = () => (
  fetch(`/v1/users/current`, { headers: auth_header })
);

const createGroup = (group) => (
  fetch(`/v1/groups`,
    {
      method: 'POST',
      body: JSON.stringify(group),
      headers: {...auth_header, 'Content-Type': 'application/json' }
    })
);

const destroyGroup = (group) => (
  fetch(`/v1/groups/${group.id}`, { method: 'DELETE', headers: auth_header })
);

const searchSchool = (term) => (
  fetch(`/v1/schools/search?term=${term}`, { headers: auth_header })
);

const searchSchoolWithExams = (term) => (
  fetch(`/v1/schools/search?term=${term}&with_exams=true`, { headers: auth_header })
);

const getSchool = (id, exam_id) => (
  fetch(`/v1/schools/${id}?exam_id=${exam_id}`, { headers: auth_header })
);

const getSchoolExcerpt = (id, exam_id, type = 'city') => (
  fetch(`/v1/schools/${id}/ranking?exam_id=${exam_id}&type=${type}`,
        { headers: auth_header })
);

const getSchoolComparison = (id, group_id, type) => (
  fetch(`/v1/schools/${id}/comparison?group_id=${group_id}&type=${type}`,
        { headers: auth_header })
);

const getSchoolQuestion = (id, question_id, exam_id, area_id, group_id) => (
  fetch(
    `/v1/schools/${id}/questions/${question_id}?exam_id=${exam_id}&area_id=${area_id}&group_id=${group_id}`,
    { headers: auth_header }
  )
);

const getSchoolQuestions = (id, exam_id, area_id, group_id) => (
  fetch(
    `/v1/schools/${id}/questions?exam_id=${exam_id}&area_id=${area_id}&group_id=${group_id}`,
    { headers: auth_header }
  )
);

const getSchoolOverviewHeader = (id, exam_id, area_id, group_id) => (
  fetch(
    `/v1/schools/${id}/overview?exam_id=${exam_id}&area_id=${area_id}&group_id=${group_id}`,
    { headers: auth_header }
  )
);

const getSchoolSubjects = (id, exam_id, area_id, group_id) => (
  fetch(
    `/v1/schools/${id}/subjects?exam_id=${exam_id}&area_id=${area_id}&group_id=${group_id}`,
    { headers: auth_header }
  )
);

const getSchoolEvolution = (id, area_id, group_id) => (
  fetch(
    `/v1/schools/${id}/evolution?area_id=${area_id}&group_id=${group_id}`,
    { headers: auth_header }
  )
);

const getSchoolHistogram = (id, exam_id, area_id, group_id) => (
  fetch(
    `/v1/schools/${id}/histogram?exam_id=${exam_id}&area_id=${area_id}&group_id=${group_id}`,
    { headers: auth_header }
  )
);

const getSchoolTags = (id, exam_id, area_id, group_id) => (
  fetch(
    `/v1/schools/${id}/tags?exam_id=${exam_id}&area_id=${area_id}&group_id=${group_id}`,
    { headers: auth_header }
  )
);

const getSchoolSkills = (id, exam_id, area_id, group_id) => (
  fetch(
    `/v1/schools/${id}/skills?exam_id=${exam_id}&area_id=${area_id}&group_id=${group_id}`,
    { headers: auth_header }
  )
);

export default { getSchool,
                 getSchoolExcerpt,
                 getSchoolComparison,
                 getSchoolQuestions,
                 getSchoolQuestion,
                 getSchoolOverviewHeader,
                 getSchoolSubjects,
                 getSchoolEvolution,
                 getSchoolHistogram,
                 getSchoolTags,
                 getSchoolSkills,
                 searchSchool,
                 createGroup,
                 destroyGroup,
                 getUser,
                 searchSchoolWithExams };
