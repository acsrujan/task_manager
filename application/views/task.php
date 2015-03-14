<?php
// Load Menu
$this->template->menu('task_view');
?>

<div id="container">

    <div class="task-info">
        <p class="task-info-title">
            <?php echo $title; ?>
        </p>
        <div class="task-info-left">
            
            <?php if($parent_tasks) : ?>
            <p class="task-info-breadcrumb">
                <?php foreach($parent_tasks as $key => $value){ ?>
                <?php echo ($key == 0)?'':'&gt;'; ?>
                <?php echo anchor(base_url()."task/view/{$project_id}/{$value['id']}", $value['title']); ?>
                <?php } ?>
                &gt;
                <?php echo $title; ?>
            </p>
            <?php endif; ?>
            
            <p class="task-info-description">
                <p><strong>Description</strong></p>
                <?php echo $description; ?>
            </p>
            
            <?php if($children_tasks) : ?>
            <p class="task-info-breadcrumb">
                <p><strong>Children</strong></p>
                <?php task_hierarchy_html($project_id, $children_tasks); ?>
            </p>
            <?php endif; ?>
            
            <?php if($files) { ?>
            <p class="task-info-files">
                <strong>Files:</strong>
                <?php echo $files; ?>
            </p>
            <?php } ?>
            <?php if($database) { ?>
            <p class="task-info-database">
                <strong>Database:</strong>
                <?php echo $database; ?>
            </p>
            <?php } ?>
        </div>
        
        <div class="task-info-right">
            <p class="task-info-priority">
                <strong>Priority:</strong>
                <?php $options = array('0' => 'Very High', '1' => 'High', '2' => 'Normal', '3' => 'Low', '4' => 'Very Low'); ?>
                <?php echo $options[$priority]; ?>
            </p>
            <p class="task-info-user">
                <strong>Assigned To:</strong>
                <em><?php echo $user; ?></em>
            </p>
             </div>
        
    </div>

</div>
