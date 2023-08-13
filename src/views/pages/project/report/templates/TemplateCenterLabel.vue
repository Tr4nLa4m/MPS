<template>
    <svg>
      <circle
        :r="pieChart.getInnerRadius() - 6"
        cx="100"
        cy="100"
        fill="#fff"
      />
      <!-- <image
        :href="getImagePath(country)"
        x="70"
        y="58"
        width="60"
        height="40"
      /> -->

      <text :style="{fontSize: 32, fontWeight: 700, color: '#333333'}" x="100" y="84" text-anchor="middle"><tspan>{{ calculateTotal(pieChart) }}</tspan></text>
      <text
        :style="{fontSize: 18}"
        text-anchor="middle"
        x="100"
        y="120"
      >
        Công việc
      </text>
    </svg>
  </template>
  <script>
  
  const formatNumber = new Intl.NumberFormat('en-US', {
    minimumFractionDigits: 0,
  }).format;
  
  export default {
    props: {
      pieChart: {
        type: Object,
        default: () => ({}),
      },
    },
    data() {
      return {
      };
    },
    methods: {
  
      calculateTotal(pieChart) {
        return formatNumber(pieChart
          .getAllSeries()[0]
          .getVisiblePoints()
          .reduce((s, p) => s + p.originalValue, 0));
      },
    },
  };
  </script>
  