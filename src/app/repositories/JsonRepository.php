<?phP

class JsonRepository implements RepositoryInterface
{
  protected $database;
  protected $index;
  private $indexers;

  function __construct()
  {
    $this->index = array();
    $this->indexers = array();
    $this->database = array();
  }

  // lazy load
  private function load()
  {
    if($this->database)
      return;

    $this->read();
  }

  public function addIndex($index, $key, $object)
  {
    $this->index[$index][$key] = $object->repo_id;
  }

  private function index($id, $object)
  {
    $object->repo_id = $id;
    $this->database[$id] = $object;
    foreach($this->indexers as $indexer)
    {
      Event::fire("cataclysm.newObject", array($this, $object));
    }
  }

  protected function read()
  {
    $id = 0;
    $this->database = array();
    $it = new RecursiveDirectoryIterator(\Config::get("cataclysm.dataPath"));
    error_log("Reading data files...");
    foreach(new RecursiveIteratorIterator($it) as $file)
    {
      $data = (array) json_decode(file_get_contents($file));
      foreach($data as $object) 
      {
        $this->index($id++, $object);
      }
    }
    $this->index($id++, json_decode('{"id":"toolset","name":"integrated toolset","type":"_SPECIAL"}'));
    $this->index($id++, json_decode('{"id":"fire","name":"nearby fire","type":"_SPECIAL"}'));
  }

  public function registerIndexer(IndexerInterface $indexer)
  {
    $this->indexers[] = $indexer;
  }

  // return a single object
  public function get($index, $id)
  {
    $this->load();
    
    if(!isset($this->index[$index][$id]))
      return null;
    $db_id = $this->index[$index][$id];
    return $this->database[$db_id];
  }

  // return all the objects in the index
  public function all($index)
  {
    $this->load();
    
    if(!isset($this->index[$index]))
      return array();

    return $this->index[$index];
  }
}
