@section('title')
Skills - Cataclysm: Dark Days Ahead
@endsection
@section('content')
<div class="row">
  <div class="col-md-3">
<ul class="nav nav-pills nav-stacked">
@foreach($skills as $key=>$skill)
<li class="@if($key==$id) active @endif"><a href="{{ route("item.skills", array($skill, $level)) }}">{{{$skill}}}</a></li>
@endforeach
</ul>
  </div>
  <div class="col-md-9">
<ul class="nav nav-tabs">
@foreach($levels as $value)
<li @if($value==$level) class="active" @endif><a href="{{ route("item.skills", array($id, $value)) }}">{{{$value}}}</a></li>
@endforeach
</ul>
@if (!$id)
Please select an entry from the menu on the left and a level on the top.
@else
<ul class="list-unstyled">
@foreach($items as $item)
  <li><a href="{{route('item.craft', $item->id)}}">{{ $item->name }}</a></li>
@endforeach
</ul>
@endif
</div>
</div>
@stop
