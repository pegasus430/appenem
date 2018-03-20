import React from 'react';
import ReactHighCharts from 'react-highcharts';
import { Card, CardTitle } from 'react-toolbox';
import ContentLoader from '../content_loader/';

const chartConfig = ({school_evolution, group_evolution}) => {
  return {
    credits: false,
    chart: {
      backgroundColor: "white"
    },
    title: {
      text: null
    },
    xAxis: {
      tickmarkPlacement: 'on'
    },
    yAxis: {
      title: {
        text: 'Nota TRI',
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
      },
      line: {
        marker: { symbol: 'circle', lineColor: 'white', lineWidth: 2 }
      }
    },
    tooltip: {
      symbol: 'circle',
      shared: true,
      valueDecimals: 1
    },
    series: [
      {
        name: 'Sua escola',
        data: school_evolution.map(({ year, avg_score }) => [year, parseFloat(avg_score)]),
        color: '#4990e2',
        lineWidth: 10,
        dashStyle: 'solid'
      },
      {
        name: 'Grupo de comparação',
        data: group_evolution.map(({ year, avg_score }) => [year, parseFloat(avg_score)]),
        color: '#50e3c2',
        dashStyle: 'dash'
      }
    ]
  };
};

const Chart = ContentLoader()(
  (props) => (
    <ReactHighCharts config={ chartConfig(props) } />
  )
);

const EvolutionChart = (props) => (
  <Card>
    <CardTitle>Evolução</CardTitle>
    <Chart {...props} />
  </Card>
);

export default EvolutionChart;
