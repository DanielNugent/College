const GITHUB_URL = "https://api.github.com";
const GITHUB_API_KEY = "";
const inputError = document.querySelector(".input-error");
const input = document.querySelector(".username-input");
const searchButton = document.querySelector(".username-button");
const page = document.querySelector(".language-chart");
const loader = document.querySelector(".loader");
const chart = document.querySelector(".language-chart");
const displayLoader = (display) => {
  loader.style.display = display ? "block" : "none";
  chart.style.display = display ? "none" : "block";
};

const getUserRepos = (userName) =>
  fetch(`${GITHUB_URL}/users/${userName}/repos`, {
    headers: {
      Authorization: `Bearer ${GITHUB_API_KEY}`,
    },
  });

const handleSearchError = (statusCode) => {
  switch (statusCode) {
    case 401:
      setInputError("Api key invalid");
      displayLoader(false);
      break;
    case 404:
      setInputError("That user doesn't exist");
      displayLoader(false);
      break;
    case 500:
      setInputError("Internal server error");
      displayLoader(false);
      break;
    case 501:
      setInputError("That user has no repos!");
      displayLoader(false);
      break;
    default:
      setInputError("Error reaching the github api...");
      displayLoader(false);
  }
};

const addData = (dataSet = {}, newData = {}) => {
  for (let [key, value] of Object.entries(newData)) {
    if (key in dataSet) {
      dataSet[key] = dataSet[key] + value;
    } else {
      dataSet[key] = value;
    }
  }
  return dataSet;
};

searchButton.addEventListener("click", () => {
  d3.select("svg").remove();
  displayLoader(true);
  let languages = {};
  getUserRepos(input.value)
    .then((res) => {
      console.log(res);
      if (res.status !== 200) {
        handleSearchError(res.status);
      } else return res.json();
    })
    .catch(() => displayLoader(false))
    .then((user) => {
      if (user) setInputError();
      if (user.length === 0) handleSearchError(501);
      user.forEach((repo, index) => {
        fetch(repo.languages_url, {
          headers: {
            Authorization: `Bearer ${GITHUB_API_KEY}`,
          },
        })
          .then((res) => {
            return res.json();
          })
          .then((data) => {
            languages = addData(languages, data);
            if (index === user.length - 1) {
              displayLoader(false);
              createChart(languages, 5);
            }
          });
      });
    })
    .catch(() => displayLoader(false));
});
const setInputError = (error = "") => {
  inputError.style.opacity = error === "" ? 0 : 1;

  inputError.innerText = error;
  if (inputError.innerText === "") inputError.innerText = ".";
};
const createChart = (data, n) => {
  console.log(data);
  ordered = Object.keys(data).sort(function (a, b) {
    return -(data[a] - data[b]);
  });

  for (let i = 0; i < ordered.length; i++) {
    if (i >= n) delete data[ordered[i]];
  }
  var svg = d3.select(".language-chart").append("svg").append("g");

  svg.append("g").attr("class", "slices");
  svg.append("g").attr("class", "labels");
  svg.append("g").attr("class", "lines");

  var width = 960,
    height = 450,
    radius = Math.min(width, height) / 2;

  var pie = d3.layout
    .pie()
    .sort(null)
    .value(function (d) {
      return d.value;
    });

  var arc = d3.svg
    .arc()
    .outerRadius(radius * 0.8)
    .innerRadius(radius * 0.4);

  var outerArc = d3.svg
    .arc()
    .innerRadius(radius * 0.9)
    .outerRadius(radius * 0.9);

  svg.attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

  var key = function (d) {
    return d.data.label;
  };

  let keys = [];
  for ([k, v] of Object.entries(data)) {
    keys.push[k];
  }
  var color = d3.scale
    .ordinal()
    .domain(keys)
    .range([
      "#98abc5",
      "#d0743c",
      "#ff8c00",
      "#8a89a6",
      "#7b6888",
      "#6b486b",
      "#a05d56",
    ]);

  function formatData(data = {}) {
    let arr = [];
    for (let [key, value] of Object.entries(data)) {
      let obj = { label: key, value: value };
      arr.push(obj);
    }
    console.log(arr);
    return arr;
  }

  change(formatData(data));

  d3.select(".randomize").on("click", function () {
    change(randomData());
  });

  function change(data) {
    /* ------- PIE SLICES -------*/
    var slice = svg
      .select(".slices")
      .selectAll("path.slice")
      .data(pie(data), key);

    slice
      .enter()
      .insert("path")
      .style("fill", function (d) {
        return color(d.data.label);
      })
      .attr("class", "slice");

    slice
      .transition()
      .duration(1000)
      .attrTween("d", function (d) {
        this._current = this._current || d;
        var interpolate = d3.interpolate(this._current, d);
        this._current = interpolate(0);
        return function (t) {
          return arc(interpolate(t));
        };
      });

    slice.exit().remove();

    /* ------- TEXT LABELS -------*/

    var text = svg.select(".labels").selectAll("text").data(pie(data), key);

    text
      .enter()
      .append("text")
      .attr("dy", ".35em")
      .text(function (d) {
        return d.data.label;
      });

    function midAngle(d) {
      return d.startAngle + (d.endAngle - d.startAngle) / 2;
    }

    text
      .transition()
      .duration(1000)
      .attrTween("transform", function (d) {
        this._current = this._current || d;
        var interpolate = d3.interpolate(this._current, d);
        this._current = interpolate(0);
        return function (t) {
          var d2 = interpolate(t);
          var pos = outerArc.centroid(d2);
          pos[0] = radius * (midAngle(d2) < Math.PI ? 1 : -1);
          return "translate(" + pos + ")";
        };
      })
      .styleTween("text-anchor", function (d) {
        this._current = this._current || d;
        var interpolate = d3.interpolate(this._current, d);
        this._current = interpolate(0);
        return function (t) {
          var d2 = interpolate(t);
          return midAngle(d2) < Math.PI ? "start" : "end";
        };
      });

    text.exit().remove();

    /* ------- SLICE TO TEXT POLYLINES -------*/

    var polyline = svg
      .select(".lines")
      .selectAll("polyline")
      .data(pie(data), key);

    polyline.enter().append("polyline");

    polyline
      .transition()
      .duration(1000)
      .attrTween("points", function (d) {
        this._current = this._current || d;
        var interpolate = d3.interpolate(this._current, d);
        this._current = interpolate(0);
        return function (t) {
          var d2 = interpolate(t);
          var pos = outerArc.centroid(d2);
          pos[0] = radius * 0.95 * (midAngle(d2) < Math.PI ? 1 : -1);
          return [arc.centroid(d2), outerArc.centroid(d2), pos];
        };
      });

    polyline.exit().remove();
  }
};
/*
  let keys = [];
  for ([key, value] of Object.entries(data)) {
    keys.push[key];
  }
  var color = d3.scale
    .ordinal()
    .domain(keys)
    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b"]);

  function formatData(data = {}) {
    let total = 0;
    for (let [key, value] of Object.entries(data)) {
      total+=value;
    }
    let arr = [];
    for (let [key, value] of Object.entries(data)) {
      let obj = { label: key, value: value/total };
      arr.push(obj);
    }
    console.log(arr);
    return arr;
  }

  change(formatData(data));*/
