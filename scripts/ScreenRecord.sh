#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Screen recording script using wf-recorder
# No persistent "recording" notification shown during capture

VIDEOS_DIR="$(xdg-user-dir VIDEOS 2>/dev/null || echo "$HOME/Videos")"
dir="$VIDEOS_DIR/Recordings"
time=$(date "+%d-%b_%H-%M-%S")
file="Recording_${time}_${RANDOM}.mp4"
pid_file="/tmp/wf-recorder.pid"

iDIR="$HOME/.config/swaync/icons"

# Ensure recordings dir exists
[[ ! -d "$dir" ]] && mkdir -p "$dir"

start_recording() {
    # If already recording, do nothing
    if [[ -f "$pid_file" ]] && kill -0 "$(cat "$pid_file")" 2>/dev/null; then
        notify-send -u low -t 3000 -i "${iDIR}/video.png" " Already Recording" "Stop with Super+Alt+R"
        return
    fi

    # Select area with slurp
    region=$(slurp 2>/dev/null)
    if [[ -z "$region" ]]; then
        # User cancelled selection
        return
    fi

    # Short start notification only (no persistent notification during recording)
    notify-send -u low -t 2000 -i "${iDIR}/video.png" " Recording Started" "Stop with Super+Alt+R"

    # Start recording in background, save PID
    wf-recorder -g "$region" -f "$dir/$file" &
    echo $! > "$pid_file"
}

stop_recording() {
    if [[ -f "$pid_file" ]]; then
        pid=$(cat "$pid_file")
        if kill -0 "$pid" 2>/dev/null; then
            # Send SIGINT so wf-recorder finalizes the file cleanly
            kill -SIGINT "$pid"
            wait "$pid" 2>/dev/null
        fi
        rm -f "$pid_file"

        # Find the most recently created recording
        latest=$(ls -t "$dir"/Recording_*.mp4 2>/dev/null | head -n1)
        if [[ -n "$latest" && -s "$latest" ]]; then
            resp=$(notify-send -t 10000 \
                -A action1=Open \
                -A action2=Delete \
                -i "${iDIR}/video.png" \
                " Recording Saved" "$(basename "$latest")")
            case "$resp" in
                action1) xdg-open "$latest" & ;;
                action2) rm "$latest" ;;
            esac
        else
            notify-send -u low -t 3000 -i "${iDIR}/video.png" " Recording" "File was empty or not saved"
        fi
    else
        notify-send -u low -t 3000 -i "${iDIR}/video.png" " Not Recording" "No active recording found"
    fi
}

case "$1" in
    --start) start_recording ;;
    --stop)  stop_recording ;;
    *)
        echo "Usage: ScreenRecord.sh --start | --stop"
        echo "  --start  Select area and start recording"
        echo "  --stop   Stop recording and save file"
        ;;
esac

exit 0
