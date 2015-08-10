package com.commonagency
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import com.commonagency.cError;

	public class cAssetLoader extends EventDispatcher 
	{		
		public var _req:URLRequest;
		public var _loader:*;
		public var _assets:Dictionary = new Dictionary();
		public var _queue_total:Number = 1;
		public var _queue:Array = [];
		public var _load_queue:Dictionary = new Dictionary();
		
		public var _loading:String = '';
		
		/**
		*	Adds the filesname to the queue to be loaded in turn.
		*/
		public function queue(filename:String):void
		{
			// only add it if it isn't already threre!
			if (_queue.indexOf(filename) == -1)	_queue.push(filename);
		}
		
		/**
		*	Makes a direct request for a certain filename.
		*	This function checks the _assets array to see if the asset is
		*	already loaded and if not attempts to load it. 
		*/
		public function get(url:String, loadFunc:Function):void
		{	
			if (_assets[url])
			{
				/*trace('got '+url+' already!');*/
				loadFunc(returnAsset(_assets[url]));
			} else {
				if (_loading == '') 
				{
					dispatchEvent(new Event(Event.INIT));
					load(url);
					/*_loader.addEventListener(Event.COMPLETE, onLoadComplete);*/
				} else {
					queue(url);
				}
				
				if (!_load_queue[url]) _load_queue[url] = [loadFunc];
				else _load_queue[url].push(loadFunc);
			}
		}
		
		/*
		private function onLoadComplete(e:Event):void
		{ 
			trace('onLoadComplete: '+_load_queue)
			while (_load_queue.length)
			{
				var func = _load_queue.pop();
				func(this.getLoaderAsset());
			}
			_loader.removeEventListener(Event.COMPLETE, onLoadComplete);
		}
		*/
		
		public function beginLoading()
		{
			if (_loading == '')
			{
				dispatchEvent(new Event(Event.INIT));
				_queue_total = _queue.length;
				if (_queue_total > 0) load(_queue.pop());
				else dispatchEvent(new Event(Event.COMPLETE));
			} else {
				cError.i.message = 'Already loading. Queued assets will be loaded automatically.';
			}
		}
	
		public function load(filename:String):void
		{
			if (_loading == '')
			{
				if (_assets[filename])
				{
					trace('cAssetLoader::already got: '+filename)
					loadNext();
				} else {
					trace('cAssetLoader::load '+filename);
					_loading = filename;
					_req = new URLRequest(filename);
					_loader = this.getNewLoader();
					_loader.load(_req);
				}
			} else {
				throw new Error('Tried to load: '+filename+' whilst loading of '+_loading+' was still in progress.');
			}
		}
		
		public function onAssetLoaded(e:Event):void
		{
			/*trace('onAssetLoaded');*/
			
			_assets[_req.url] = this.getLoaderAsset();
			
			// if something's been added to the _load_queue then trigger it (it should be in the same order as queue so this should be fine.)
			if (_load_queue[_loading])
			while(_load_queue[_loading].length)
			{
				var func = _load_queue[_loading].pop();
				func(returnAsset(this.getLoaderAsset()));
			}
			
			_loading = '';
			loadNext();
		}
		
		public function loadNext():void
		{
			if (_queue.length)
			{
				load(_queue.pop());
			} else {
				dispatchEvent(new Event(Event.COMPLETE));
			}			
		}
		
		/**
		*	This function listerally gets an asset form the pile.
		*	If the asset isn't loaded yet it does nothing - therefore
		*	you shoudln't call this unless you know the asset is loaded.
		*/		
		public function getAsset(url:String):*
		{
			if (_assets[url])
			{
				// trace('got asset already!');
				return returnAsset(_assets[url]);
			} else {
				throw new Error('Asset ['+url+'] hasn\'t been loaded yet. Use get() if you\'re not sure whether it has or not.');
			}
		}
		
		public function onProgress(e:ProgressEvent):void
		{	
			var seg = 100/_queue_total;
			var dif = _queue_total - _queue.length - 1;
			var done = seg * dif
			
			var p = new ProgressEvent('progress');
			p.bytesLoaded = done + (seg * (e.bytesLoaded/e.bytesTotal));
			p.bytesTotal = 100;
			dispatchEvent(p)
		}
		
		public function IOErrorFunc(e:IOErrorEvent)
		{
			cError.i.message = 'Could not find the file - '+_loading;
		}
		
		public function getLoaderAsset():*
		{
			throw new Error('addAsset - must be overritten by child class - there is no default')
		}
		
		public function getNewLoader():*
		{
			throw new Error('getNewLoader - must be overritten by child class - there is no default.')
		}
		
		/**
		*	This function is quite important for images where you 
		*	don't want to return the actual asset but rather a copy 
		*	of it.
		*/
		public function returnAsset(asset:*):*
		{
			return asset;
		}

	}
}