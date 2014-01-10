<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-images">
  <div class="row">
    <div class="panel panel-default">
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">Images</h4>
      </div>
      {{/unless}}
      <div class="panel-body">
	<div class="row">
	  {{#if model.pageData.tmdb.posters}}
	  <h4 class="panel-heading">Posters</h4>
          {{#each model.pageData.tmdb.posters}}
          <span class="col-xs-6 col-sm-4 col-md-3 col-lg-3 panel">
	    <span class="poster-image">
	      <a target="_blank" href="{{unbound image_url}}">
		<img {{bind-attr src=image_url_thumb}} />
	      </a>
	    </span>
	  </span>
	  {{#ifIndexMod 4}}<div class="clearfix visible-md visible-lg"></div>{{/ifIndexMod}}
	  {{#ifIndexMod 3}}<div class="clearfix visible-sm"></div>{{/ifIndexMod}}
	  {{#ifIndexMod 2}}<div class="clearfix visible-xs"></div>{{/ifIndexMod}}
          {{/each}}
	  {{/if}}
	</div>
	<div class="row">
	  {{#if model.pageData.tmdb.backdrops}}
	  <h4 class="panel-heading">Backdrops</h4>
          {{#each model.pageData.tmdb.backdrops}}
          <span class="col-xs-6 col-sm-6 col-md-4 col-lg-4 panel">
	    <span class="backdrop-image">
	      <a target="_blank" href="{{unbound image_url}}">
		<img {{bind-attr src=image_url_thumb}} />
	      </a>
	    </span>
	  </span>
	  {{#ifIndexMod 3}}<div class="clearfix visible-md visible-lg"></div>{{/ifIndexMod}}
	  {{#ifIndexMod 2}}<div class="clearfix visible-sm visible-xs"></div>{{/ifIndexMod}}
          {{/each}}
	  {{/if}}
	</div>
      </div>
    </div>
  </div>
</script>

