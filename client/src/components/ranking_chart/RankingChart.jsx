import React from 'react';
import ReactHighCharts from 'react-highcharts';
import { Card, CardTitle } from 'react-toolbox';
import ContentLoader from '../content_loader/';

const chartConfig = ({reversed, years, school, comparison_schools}) => {
  return {
    credits: false,
    chart: {
      backgroundColor: "white"
    },
    title: {
      text: null
    },
    xAxis: {
      categories: years,
      tickmarkPlacement: 'on'
    },
    yAxis: {
      reversed,
      title: {
        text: 'Posição',
      },
    },
    legend: {
      layout: 'horizontal',
      align: 'center',
      verticalAlign: 'bottom'
    },
    plotOptions: {
      symbol: 'circle',
      series: {
        marker: {
          lineColor: 'white'
        },
        dashStyle: 'dash'
      },
      line: {
        marker: { symbol: 'circle', lineColor: 'white', lineWidth: 2 }
      }
    },
    tooltip: {
      symbol: 'circle',
      shared: true,
      valueSuffix: 'º'
    },
    series: [
      ...comparison_schools.map(({ name, positions }) => ({ name, data: positions })),
      {
        name: school.name,
        data: school.positions,
        color: '#9012fe',
        lineWidth: 10,
        dashStyle: 'solid'
      }
    ]
  };
};

const Chart = ContentLoader()(
  (props) => (
    <ReactHighCharts config={ chartConfig(props) } />
  )
);

const RankingChart = (props) => (
  <Card>
    <CardTitle>Ranking</CardTitle>
    <Chart {...props} />
  </Card>
);

export default RankingChart;
