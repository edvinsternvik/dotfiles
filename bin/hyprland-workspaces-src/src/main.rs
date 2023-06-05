use hyprland::{
    data::Workspace,
    dispatch::{Dispatch, DispatchType, WorkspaceIdentifier, WorkspaceIdentifierWithSpecial},
    shared::HyprDataActive,
};
use std::env;

fn main() {
    let cli_args: Vec<String> = env::args().collect();

    let command = cli_args
        .get(1)
        .map(|s| s.as_str())
        .expect("No command supplied");

    match command {
        "workspace" => {
            let workspace_id = cli_args
                .get(2)
                .and_then(|s| s.parse::<u32>().ok())
                .expect("No argument supplied");
            workspace(workspace_id)
        }
        "movetoworkspace" => {
            let workspace_id = cli_args
                .get(2)
                .and_then(|s| s.parse::<u32>().ok())
                .expect("No argument supplied");
            move_to_workspace(workspace_id)
        }
        "movetoworkspacesilent" => {
            let workspace_id = cli_args
                .get(2)
                .and_then(|s| s.parse::<u32>().ok())
                .expect("No argument supplied");
            move_to_workspace_silent(workspace_id)
        }
        _ => panic!("Invalid command: \"{}\"", command),
    };
}

fn workspace(workspace_id: u32) {
    let workspace_id = get_actual_workspace_id(workspace_id) as i32;

    let dispatch = DispatchType::Workspace(WorkspaceIdentifierWithSpecial::Id(workspace_id));
    Dispatch::call(dispatch).expect("Unable to call dispatch");
}

fn move_to_workspace(workspace_id: u32) {
    let workspace_id = get_actual_workspace_id(workspace_id) as i32;

    let dispatch = DispatchType::MoveToWorkspace(WorkspaceIdentifier::Id(workspace_id), None);
    Dispatch::call(dispatch).expect("Unable to call dispatch");
}

fn move_to_workspace_silent(workspace_id: u32) {
    let workspace_id = get_actual_workspace_id(workspace_id) as i32;

    let dispatch = DispatchType::MoveToWorkspaceSilent(WorkspaceIdentifier::Id(workspace_id), None);
    Dispatch::call(dispatch).expect("Unable to call dispatch");
}

fn get_actual_workspace_id(workspace_id: u32) -> u32 {
    if workspace_id > 9 {
        panic!("Workspace ids > 9 are not supported");
    }

    let current_workspace = Workspace::get_active().expect("No active workspace");
    let workspace_group_id = (current_workspace.id as u32) / 10;
    workspace_group_id * 10 + workspace_id
}
