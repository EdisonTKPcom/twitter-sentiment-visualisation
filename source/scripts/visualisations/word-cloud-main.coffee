
WIDTH = 600  # Width constant for canvas and chart
HEIGHT = 600 # Height constant for canvas and chart

getSentimentForWord = (word) ->
  for each in wordData then if each.text == word then return each.sentiment
  0 # if for some reason we can't find the word, then just return neutral.

scaleColors = ["#a50026","#d73027","#f46d43","#fdae61","#fee08b","#ffffbf",
               "#d9ef8b","#a6d96a","#66bd63","#1a9850","#006837"]

fillScale = d3.scale.linear()
.domain([-1,-0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1])
.range(scaleColors)

sizeScale = d3.scale.linear()
.domain([0,100])
.range([10,80])



draw = (words) ->
  d3.select('svg#cloud')
    .attr('width', WIDTH+200)
    .attr('height', HEIGHT+100)
    .style('padding', '50px')
    .style('opacity', '0.8')
    .append('g')
    .attr('transform', 'translate(150,150)')
    .selectAll('text')
    .data(words)
    .enter()
    .append('text')
    .style('font-size', (d) -> d.size + 'px')
    .style('font-family', 'Impact')
    .style('fill', (d, i) -> fillScale getSentimentForWord d.text)
    .attr('text-anchor', 'middle')
    .attr('transform', (d) ->
      'translate(' + [d.x, d.y,] + ')rotate(' + d.rotate + ')')
    .text (d) -> d.text

d3.layout.cloud().size([WIDTH, HEIGHT])
  .words(wordData)
  .rotate(-> ~ ~ (Math.round(Math.random()*5)*45)-90)
  .font('Impact').fontSize((d) -> sizeScale d.freq )
  .on('end', draw).start()