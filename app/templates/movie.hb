<script type="text/x-handlebars" data-template-name="Nmdb-sectionlink">
  {{#if section.disabled}}
  <a href="javascript:void(0);">{{section.display}}</a>
  {{else}}
  {{#link-to 'movie' movie.id page=section.name}}{{section.display}}{{/link-to}}
  {{/if}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie">
  <div class="col-xs-12">
    <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="well well-sm">
	<h1 class="page-header">{{movie.full_title}}</h1>
	<div class="row container col-xs-12 col-sm-12 col-md-12 col-lg-12">
	  {{#each genres}}
	  <span class="label label-default">{{genre}}</span>
	  {{/each}}
	</div>
	<div class="hidden row container col-xs-12 col-sm-12 col-md-12 col-lg-12">
	  {{#each keywords}}
	  <span class="label label-default">{{id}} {{keyword}}</span>
	  {{/each}}
	</div>
      </div>
    </div>
    <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <ul class="nav nav-pills">
	{{#each section in sections}}
	{{view Nmdb.SectionLink}}
	{{/each}}
      </ul>
    </div>
    <div class="container row">&nbsp;</div>
  </div>
  {{view Nmdb.CurrentView}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-keywords">
  <div class="col-xs-12">
    <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="panel panel-default">
	<div class="panel-heading">
	  <h4 class="panel-title">Keywords</h4>
	</div>
	<div class="panel-body">
	  {{#each keywords}}
	  <span class="col-xs-6 col-sm-4 col-md-3 col-lg-3 panel">{{keyword}}</span>
	  {{/each}}
	</div>
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-quotes">
  <div class="col-xs-12">
    <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="panel panel-default">
	<div class="panel-heading">
	  <h4 class="panel-title">Quotes</h4>
	</div>
	<div class="panel-body">
	</div>
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-cast">
  <div class="col-xs-12">
    <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="panel panel-default">
	<div class="panel-heading">
	  <h4 class="panel-title">Cast</h4>
	</div>
	<div class="panel-body">
	  <div class="container row col-xs-12 col-sm-12 table-responsive">
	    <table class="table table-condensed">
	      <thead>
		<tr>
		  <th width="1%"></th>
		  <th width="39%">Cast</th>
		  <th width="60%">Character</th>
		</tr>
	      </thead>
	      <tbody>
		{{#each cast_members}}
		<tr>
		  <th>{{sort_value}}</th>
		  <td>{{#link-to 'person' id}}{{name}}{{/link-to}}</td>
		  <td>
		    {{character}} {{extras}}
		    {{#if episode_count}}({{episode_count}} episodes){{/if}}
		  </td>
		</tr>
		{{/each}}
	      </tbody>
	    </table>
	  </div>
	</div>
      </div>
    </div>
  </div>
</script>
