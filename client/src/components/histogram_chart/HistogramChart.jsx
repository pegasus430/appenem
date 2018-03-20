import React from 'react';
import ReactHighCharts from 'react-highcharts';
import ContentLoader from '../content_loader/';

const chartConfig = ({ school, comparison_group }) => {
  const school_total = school.map(({ quantity }) => quantity)
                             .reduce((q1, q2) => q1 + q2, 0) / 100;
  const comparison_total = comparison_group.map(({ quantity }) => quantity)
                                           .reduce((q1, q2) => q1 + q2, 0) / 100;

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
        text: 'Alunos (%)',
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
        }
      },
      line: {
        marker: { symbol: 'circle', lineColor: 'white', lineWidth: 2 }
      }
    },
    tooltip: {
      symbol: 'circle',
      shared: true,
      valueDecimals: 1,
      valueSuffix: '%'
    },
    series: [
      {
        name: 'Sua escola',
        data: school.map(({ range_score, quantity }) =>
                         [range_score, quantity / school_total]),
        color: '#4990e2',
        type: 'column'
      },
      {
        name: 'Grupo de comparação',
        data: comparison_group.map(({ range_score, quantity }) =>
                                   [range_score, quantity / comparison_total]),
        color: '#50e3c2',
        type: 'line'
      }
    ]
  };
};

const HistogramChart = ContentLoader()(
  (props) => (
    <ReactHighCharts config={ chartConfig(props) } />
  )
);

export default HistogramChart;
