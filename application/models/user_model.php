<?php

class User_model extends CI_Model {

    private $salt = 't3$ting';
    

    public function create($data)
    {
        $data['password'] = sha1($data['password'].$this->salt);
        $insert = $this->db->insert('user', $data);
        return $insert;
    }

    public function update($id, $data)
    {
        if(isset($data['password']))
            $data['password'] = sha1($data['password'].$this->salt);
        $this->db->where('id', $id);
        $update = $this->db->update('user', $data);
        return $update;
    }

    public function get($id = false)
    {
        if ($id) $this->db->where('id', $id);
        $this->db->order_by('email', 'asc');
        $get = $this->db->get('user');

        if($id) return $get->row_array();
        if($get->num_rows > 0) return $get->result_array();
        return array();
    }
    
    public function get_count()
    {
        $this->db->select('count(*) as count');
        $get = $this->db->get('user')->row_array();

        return $get['count'];
    }
    
    public function validate($email, $password)
    {
        $this->db->where('email', $email)->where('password', sha1($password.$this->salt));
        $get = $this->db->get('user');

        if($get->num_rows > 0) return $get->row_array();
        return array();
    }

    public function delete($id)
    {
        $this->db->where('id', $id);
        $this->db->delete('user');
    }

}
