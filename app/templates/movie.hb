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
	<li {{bind-attr class="section_selected_cast:active"}}>{{#link-to 'movie' movie.id page='cast'}}Cast{{/link-to}}</li>
	<li {{bind-attr class="section_selected_keywords:active"}}>{{#link-to 'movie' movie.id page='keywords'}}Keywords{{/link-to}}</li>
	<li {{bind-attr class="section_selected_quotes:active"}}>{{#link-to 'movie' movie.id page='quotes'}}Quotes{{/link-to}}</li>
      </ul>
    </div>
    <div class="container row">&nbsp;</div>
  </div>
  {{#if section_selected_cast}}
  {{partial "movie/cast"}}
  {{/if}}
  {{#if section_selected_keywords}}
  {{partial "movie/keywords"}}
  {{/if}}
  {{#if section_selected_quotes}}
  {{partial "movie/quotes"}}
  {{/if}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie/_keywords">
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

<script type="text/x-handlebars" data-template-name="Nmdb-movie/_quotes">
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

<script type="text/x-handlebars" data-template-name="Nmdb-movie/_cast">
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
