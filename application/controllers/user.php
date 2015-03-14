<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class User extends CI_Controller {
    
    
    private $error = false;
        
    function User()
    {
        parent::__construct();
        
        if(!$this->usercontrol->has_permission('user'))
            redirect('dashboard');
        ;
    }
    
    public function index()
    {
        // Load open transports
        $this->load->model('user_model');
        $data['users'] = $this->user_model->get(false);
        
        $data['page_title']  = "Users";
        
        // Load View
        $this->template->show('users', $data);
    }

    public function add()
    {
        $data['page_title']  = "New User";
        $data['email']    = '';
        $data['password'] = '';
        
        if($this->error)
            $data['error'] = $this->error;
        
        $this->template->show('users_add', $data);
    }

    public function edit($id)
    {
        $this->load->model('user_model');
        $data = $this->user_model->get($id);
        
        $data['password'] = '';
        $data['page_title']  = "Edit User #".$id;
        
        if($this->error)
            $data['error'] = $this->error;
        
        $this->template->show('users_add', $data);
    }
    
    public function remove($id)
    {
        $this->load->model('user_model');
        $this->user_model->delete($id);
        
        redirect('user');
    }
    
    public function save()
    {
        if($this->input->post('cancel') !== FALSE)
            redirect('user');
            
        $user_id = $this->input->post('id');
        
        $this->load->library('form_validation');
        
        $this->form_validation->set_rules('email', 'Email', 'trim|required|valid_email');
        $this->form_validation->set_rules('password', 'Password', 'trim');
        
        if($this->form_validation->run() === false)  {
            $this->error = true;
            
            if ($user_id)
                $this->edit ($user_id);
            else
                $this->add ();
            
            return;
        }
        
        $this->load->model('user_model');
        
        $sql_data = array(
            'email'    => $this->input->post('email'))
         ;
        
        if($this->input->post('reset_password')){
            $sql_data['password'] = $this->input->post('password');
        }
        
        if ($user_id)
            $this->user_model->update($user_id,$sql_data);
        else
            $this->user_model->create($sql_data);

        redirect('user');
    }
    
}
