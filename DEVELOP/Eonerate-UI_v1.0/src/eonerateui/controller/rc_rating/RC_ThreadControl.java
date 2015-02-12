package eonerateui.controller.rc_rating;

public class RC_ThreadControl {
	private boolean deleteDetail = false;
	private boolean deleteAggregated = false;
	private boolean createDone = false;
	private boolean hasError = false;
	
	public boolean isDone() {
		return deleteDetail & deleteAggregated & createDone;
	}

	public boolean hasError() {
		return hasError;
	}

	public void setDeleteDetailDone(boolean _deleteDetail) {
		this.deleteDetail = _deleteDetail;
	}

	public void setDeleteAggregatedDone(boolean _deleteAggregated) {
		this.deleteAggregated = _deleteAggregated;
	}

	public void setCreateTempDone(boolean _createDone) {
		this.createDone = _createDone;
	}

	public void setHasError(boolean _hasError) {
		this.hasError = _hasError;
	}
}
