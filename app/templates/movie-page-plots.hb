<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-plots">
  <div class="row">
    <div class="panel panel-default">
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">Plot summary</h4>
      </div>
      {{/unless}}
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	<ul class="list-group no-margin">
	  {{#each model.pageData}}
          <li class="list-group-item plot-summary">
	    {{decodeLinks plot links}}
	    <div><em class="pull-right">{{author}}</em></div>
	  </li>
	  {{/each}}
	</ul>
      </div>
    </div>
  </div>
</script>

