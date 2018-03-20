import React from 'react';
import ReactHighCharts from 'react-highcharts';

const chartConfig = ({ alternatives }) => {
  const school_total = alternatives.map(({ own_frequency }) => own_frequency)
                             .reduce((q1, q2) => q1 + q2) / 100;
  const comparison_total = alternatives.map(
    ({ comparison_frequency }) => comparison_frequency
  ).reduce((q1, q2) => q1 + q2) / 100;

  return {
    credits: false,
    chart: {
      backgroundColor: "white"
    },
    title: {
      text: null
    },
    xAxis: {
      tickmarkPlacement: 'on',
      categories: alternatives.map(({ label }) => label)
    },
    yAxis: {
      title: {
        text: 'Marcações',
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
      column: {
        grouping: false
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
        name: 'Grupo de comparação',
        data: alternatives.map(
          ({comparison_frequency }) => comparison_frequency / comparison_total),
        color: '#50e3c2',
        type: 'column',
        pointPadding: 0,
        groupPadding: 0.1
      },
      {
        name: 'Sua escola',
        data: alternatives.map(
          ({ own_frequency }) => own_frequency / school_total),
        color: '#4990e2',
        type: 'column',
        borderWidth: 0
      }
    ]
  };
};

const AlternativeChart = (props) => (
  <ReactHighCharts config={ chartConfig(props) } />
);

export default AlternativeChart;
