<div id="task_<?php echo $task['task_id']; ?>" <?php if($task['status'] == 3) { ?> title="<?php echo strip_tags($task['description']); ?>"<?php } ?>
        class="task <?php echo ($task['user_id'] == $current_user)?'my-task':'project-task'; ?>">
    <p class="task_id">#<?php echo $task['code']; ?></p>
    <p class="task_title"><?php echo anchor('task/view/'.$project.'/'.$task['task_id'], $task['title']); ?></p>
    <p class="task_user">Assigned to: <?php echo $users[$task['user_id']]['email']; ?></p>
    
    <?php if($task['status'] == 0) { ?>
    <p class="task_links"><?php echo anchor('task/move/'.$project.'/'.$task['task_id'].'/1', 'Finish &raquo;'); ?></p>

    <?php } else if($task['status'] == 1) { ?>
    <p class="task_links"><?php echo anchor('task/move/'.$project.'/'.$task['task_id'].'/0', '&laquo; Back'); ?></p>
    <?php } ?>
</div>
