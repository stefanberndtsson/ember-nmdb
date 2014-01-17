<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-taglines">
  <div class="row">
    <div class="panel panel-default">
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">Taglines</h4>
      </div>
      {{/unless}}
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	<ul class="list-group no-margin">
	  {{#each model.pageData}}
          <li class="list-group-item">
	    {{tagline}}
	  </li>
	  {{/each}}
	</ul>
      </div>
    </div>
  </div>
</script>

